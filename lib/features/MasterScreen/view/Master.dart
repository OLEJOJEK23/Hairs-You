import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/entities/master.dart';
import 'package:hairs_and_you/api/domain/usecases/add_booking.dart';
import 'package:hairs_and_you/controllers/Auth_contoroller.dart';
import 'package:hairs_and_you/widgets/FavoriteButtonWidget.dart';

import '../../../api/domain/entities/photo.dart';
import '../../../api/domain/usecases/get_masters.dart';
import '../../../api/domain/usecases/get_photos.dart';
import '../../../blocks/booking_block/booking_bloc.dart';
import '../../../widgets/ImageScroll.dart';

@RoutePage()
class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key, @PathParam('id') required this.id});

  final String id;

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  final GetMasters _getMasters = GetIt.I<GetMasters>();
  late Master _master;
  bool _isMastersLoading = false;
  String? _mastersError;
  String? _photosError;
  bool _isPhotosLoading = false;
  final GetPhotos _getPhotos = GetIt.I<GetPhotos>();
  List<Photo> _imageUrls = [];

  void _selectMaster() {
    // Открываем диалог подтверждения
    showDialog(
      context: context,
      builder: (context) => BookingConfirmationDialog(
        masterName: _master.fullName,
        masterId: _master.id,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchMaster();
    _fetchPhotos();
  }

  Future<void> _fetchMaster() async {
    setState(() {
      _isMastersLoading = true;
      _mastersError = null;
    });
    final result = await _getMasters(
        userID: AuthController.userID,
        salonID: context.read<BookingBloc>().state.salonId,
        masterID: widget.id);
    result.fold(
      (failure) => setState(() {
        _mastersError = failure.message;
        _isMastersLoading = true;
      }),
      (masters) => setState(() {
        _master = masters[0];
        _isMastersLoading = false;
      }),
    );
    if (_mastersError != null) {
      print(_mastersError);
    }
  }

  Future<void> _fetchPhotos() async {
    setState(() {
      _isPhotosLoading = true;
      _photosError = null;
    });
    final result = await _getPhotos(entityID: widget.id, entityType: "master");
    result.fold(
      (failure) => setState(() {
        _photosError = failure.message;
        _isPhotosLoading = true;
      }),
      (photos) => setState(() {
        _imageUrls = photos;
        _isPhotosLoading = false;
      }),
    );
    if (_photosError != null) {
      print(_photosError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _isMastersLoading || _isPhotosLoading
        ? Center(
            child: CircularProgressIndicator(
              color: theme.primaryColor,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                "Выбор мастера",
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: theme.scaffoldBackgroundColor,
              surfaceTintColor: theme.scaffoldBackgroundColor,
              actions: [
                FavoriteButton(
                  type: "master",
                  id: _master.id,
                  initialFavorite: _master.isFavorite,
                )
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.surface,
                    theme.colorScheme.surfaceContainerLow
                        .withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Scrollable list of photos with indicator
                      ImageScroll(
                        imageUrls: _imageUrls,
                      ),
                      const SizedBox(height: 16),
                      // Full name
                      Text(
                        _master.fullName,
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Description
                      Text(
                        _master.description == null
                            ? "описания нет"
                            : _master.description!,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      // Buttons
                      const Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _selectMaster();
                            },
                            child: const Text(
                              "Подтвердить",
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
                ),
              ),
            ),
          );
  }
}

// Всплывающее окно подтверждения
class BookingConfirmationDialog extends StatelessWidget {
  final String masterName;
  final String masterId;

  const BookingConfirmationDialog({
    super.key,
    required this.masterName,
    required this.masterId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final AddBooking _addBooking = GetIt.I<AddBooking>();
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        // Форматируем данные для отображения
        final salonName = state.salon?.name ?? 'Не выбран';
        final serviceName = state.selectedService?.service_name ?? 'Не выбрана';
        final dateTime = state.selectedDateTime != null
            ? state.selectedDateTime!.toLocal().toString().substring(0, 16)
            : 'Не выбрано';
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Подтверждение записи',
            style: theme.textTheme.titleMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Салон: $salonName', style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text('Услуга: $serviceName', style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text('Дата и время: $dateTime',
                  style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text('Мастер: $masterName', style: theme.textTheme.bodyMedium),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Отмена',
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _addBooking(
                  userID: AuthController.userID,
                  salonID: state.salonId!,
                  serviceID: state.selectedService!.id,
                  dateTime: state.selectedDateTime!,
                  masterID: masterId,
                );
                if (context.mounted) {
                  context.router.replaceNamed('/');
                }
              },
              style: theme.elevatedButtonTheme.style,
              child: Text(
                'Подтвердить',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}
