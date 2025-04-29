import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hairs_and_you/api/core/network/dio_client.dart';
import 'package:hairs_and_you/api/data/datasources/local/cache_manager.dart';
import 'package:hairs_and_you/api/data/datasources/remote/api_service.dart';
import 'package:hairs_and_you/api/data/repositories/place_repository_impl.dart';
import 'package:hairs_and_you/api/domain/entities/place.dart';
import 'package:hairs_and_you/api/domain/usecases/get_nearby_salons.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};
  String? _selectedPlaceId;
  String? _selectedAddress;
  Timer? _debounce;
  BitmapDescriptor? _usersLocationMarker;
  BitmapDescriptor? _salonLocationMarker;

  // Временная инъекция зависимостей (в реальном проекте используйте GetIt)
  late final GetNearbySalons _getNearbySalons;

  @override
  void initState() {
    super.initState();
    _getNearbySalons = GetNearbySalons(
      PlaceRepositoryImpl(
        apiService: ApiService(DioClient.googleMapsInstance),
        cacheManager: CacheManagerImpl(),
      ),
    );
    _getCurrentLocation();
    _loadMarkerIcons();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadMarkerIcons() async {
    _usersLocationMarker = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/user_location.png',
    );
    _salonLocationMarker = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/salon_marker.png',
    );
    setState(() {});
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showError('Пожалуйста, включите геолокацию');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showError('Разрешение на геолокацию отклонено');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showError('Разрешение на геолокацию отклонено навсегда');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });

      await _moveCameraToCurrentLocation();
      await _fetchNearbySalons();
    } catch (e) {
      _showError('Ошибка получения местоположения: $e');
    }
  }

  Future<void> _moveCameraToCurrentLocation() async {
    if (_currentPosition != null) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentPosition!, zoom: 14.0),
        ),
      );
    }
  }

  Future<void> _fetchNearbySalons({LatLngBounds? bounds}) async {
    final targetPosition = bounds != null
        ? LatLng(
            (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
            (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
          )
        : _currentPosition;

    if (targetPosition == null) return;

    final result = await _getNearbySalons(targetPosition);
    result.fold(
      (failure) => _showError(failure.message),
      (places) => _updateMarkers(places, isInitialLoad: bounds == null),
    );
  }

  void _updateMarkers(List<Place> places, {required bool isInitialLoad}) {
    setState(() {
      if (isInitialLoad) {
        _markers.clear();
      }

      if (isInitialLoad &&
          _currentPosition != null &&
          _usersLocationMarker != null) {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: _currentPosition!,
            infoWindow: const InfoWindow(title: 'Ваше местоположение'),
            icon: _usersLocationMarker!,
          ),
        );
      }

      for (var place in places) {
        _markers.add(
          Marker(
            markerId: MarkerId(place.id),
            position: LatLng(place.latitude, place.longitude),
            infoWindow: InfoWindow(title: place.name, snippet: place.address),
            icon: _salonLocationMarker ?? BitmapDescriptor.defaultMarker,
            onTap: () {
              setState(() {
                _selectedPlaceId = place.id;
                _selectedAddress = place.address;
              });
            },
          ),
        );
      }
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ближайшие парикмахерские'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _currentPosition == null
                ? Center(
                    child: CircularProgressIndicator(
                      color: theme.primaryColor,
                    ),
                  )
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition!,
                      zoom: 14.0,
                    ),
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraIdle: () async {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce =
                          Timer(const Duration(milliseconds: 500), () async {
                        final controller = await _controller.future;
                        final bounds = await controller.getVisibleRegion();
                        await _fetchNearbySalons(bounds: bounds);
                      });
                    },
                  ),
          ),
          if (_selectedPlaceId != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedAddress != null) {
                      Navigator.pop(context, _selectedAddress);
                    }
                  },
                  style: theme.elevatedButtonTheme.style,
                  child: const Text(
                    'Подтвердить',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
