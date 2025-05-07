part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final String? salonId;
  final Salon? salon;
  final Services? selectedService;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String? masterId;

  const BookingState({
    this.salonId,
    this.salon,
    this.selectedService,
    this.selectedDate,
    this.selectedTime,
    this.masterId,
  });

  @override
  List<Object?> get props => [
        salonId,
        salon,
        selectedService,
        selectedDate,
        selectedTime,
        masterId,
      ];
}

class BookingInitial extends BookingState {
  const BookingInitial() : super();
}
