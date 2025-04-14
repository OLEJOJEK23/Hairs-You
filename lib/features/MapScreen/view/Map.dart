import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

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
  static const String _apiKey = 'AIzaSyBgy6Dza_gIvk2IcaeItlOU9ZBwl1CykL4';
  String? _selectedPlaceId;
  String? _selectedAddress;
  Timer? _debounce;
  BitmapDescriptor? _usersLocationMarker;
  BitmapDescriptor? _salonLocationMarker;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadMarkerIcons();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  // Загрузка кастомных иконок для маркеров
  Future<void> _loadMarkerIcons() async {
    _usersLocationMarker = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/user_location.png', // Иконка для текущего местоположения
    );
    _salonLocationMarker = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/6395517.png', // Иконка для парикмахерских
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

  String _buildRequestUrl(LatLng targetPosition) {
    const String baseUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    return '$baseUrl?location=${targetPosition.latitude},${targetPosition.longitude}'
        '&radius=5000&type=hair_care&language=ru&key=$_apiKey';
  }

  Future<List<dynamic>?> _fetchPlacesData(String requestUrl) async {
    try {
      final response = await http.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['results'] as List<dynamic>;
      } else {
        _showError('Ошибка загрузки парикмахерских');
        return null;
      }
    } catch (e) {
      _showError('Ошибка запроса к API: $e');
      return null;
    }
  }

  void _updateMarkers(List<dynamic> results, {required bool isInitialLoad}) {
    setState(() {
      if (isInitialLoad) {
        _markers.clear();
      }

      if (isInitialLoad && _currentPosition != null) {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: _currentPosition!,
            infoWindow: const InfoWindow(title: 'Ваше местоположение'),
            icon: _usersLocationMarker!, // Иконка для текущего местоположения
          ),
        );
      }

      for (var place in results) {
        final lat = place['geometry']['location']['lat'];
        final lng = place['geometry']['location']['lng'];
        final name = place['name'];
        final address = place['vicinity'] ?? 'Адрес не указан';
        final placeId = place['place_id'];

        _markers.add(
          Marker(
            markerId: MarkerId(placeId),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: name, snippet: address),
            icon: _salonLocationMarker!,
            onTap: () {
              setState(() {
                _selectedPlaceId = placeId;
                _selectedAddress = address;
              });
            },
          ),
        );
      }
    });
  }

  Future<void> _fetchNearbySalons({LatLngBounds? bounds}) async {
    final targetPosition = bounds != null
        ? LatLng(
            (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
            (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
          )
        : _currentPosition;

    if (targetPosition == null) return;

    final requestUrl = _buildRequestUrl(targetPosition);
    final results = await _fetchPlacesData(requestUrl);

    if (results != null) {
      _updateMarkers(results, isInitialLoad: bounds == null);
    }
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
          // Контейнер для кнопки подтверждения
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
