part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final String? salonId;
  final Salon? salon;
  final Services? selectedService;
  final DateTime? selectedDateTime;
  final String? masterId;

  const BookingState({
    this.salonId,
    this.salon,
    this.selectedService,
    this.selectedDateTime,
    this.masterId,
  });

  @override
  List<Object?> get props => [
        salonId,
        salon,
        selectedService,
        selectedDateTime,
        masterId,
      ];
}

class BookingInitial extends BookingState {
  const BookingInitial() : super();
}
