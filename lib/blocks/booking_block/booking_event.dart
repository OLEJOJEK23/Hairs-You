part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class SelectSalon extends BookingEvent {
  final String salonId;
  final Salon salon;

  const SelectSalon(this.salonId, this.salon);

  @override
  List<Object?> get props => [salonId, salon];
}

class SelectService extends BookingEvent {
  final Services service;

  const SelectService(this.service);

  @override
  List<Object?> get props => [service];
}

class SelectDateTime extends BookingEvent {
  final DateTime dateTime;

  const SelectDateTime(this.dateTime);

  @override
  List<Object?> get props => [dateTime];
}

class SelectMaster extends BookingEvent {
  final String masterId;

  const SelectMaster(this.masterId);

  @override
  List<Object?> get props => [masterId];
}

class ClearBooking extends BookingEvent {
  const ClearBooking();
}
