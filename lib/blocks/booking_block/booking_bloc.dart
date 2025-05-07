import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/api/domain/entities/salon.dart';
import 'package:hairs_and_you/api/domain/entities/service.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<SelectSalon>(_onSelectSalon);
    on<SelectService>(_onSelectService);
    on<SelectDateTime>(_onSelectDateTime);
    on<SelectMaster>(_onSelectMaster);
    on<ClearBooking>(_onClearBooking);
  }

  void _onSelectSalon(SelectSalon event, Emitter<BookingState> emit) {
    emit(BookingState(
      salonId: event.salonId,
      salon: event.salon,
      selectedService: state.selectedService,
      selectedDate: state.selectedDate,
      selectedTime: state.selectedTime,
      masterId: state.masterId,
    ));
  }

  void _onSelectService(SelectService event, Emitter<BookingState> emit) {
    emit(BookingState(
      salonId: state.salonId,
      salon: state.salon,
      selectedService: event.service,
      selectedDate: state.selectedDate,
      selectedTime: state.selectedTime,
      masterId: state.masterId,
    ));
  }

  void _onSelectDateTime(SelectDateTime event, Emitter<BookingState> emit) {
    emit(BookingState(
      salonId: state.salonId,
      salon: state.salon,
      selectedService: state.selectedService,
      selectedDate: event.date,
      selectedTime: event.time,
      masterId: state.masterId,
    ));
  }

  void _onSelectMaster(SelectMaster event, Emitter<BookingState> emit) {
    emit(BookingState(
      salonId: state.salonId,
      salon: state.salon,
      selectedService: state.selectedService,
      selectedDate: state.selectedDate,
      selectedTime: state.selectedTime,
      masterId: event.masterId,
    ));
  }

  void _onClearBooking(ClearBooking event, Emitter<BookingState> emit) {
    emit(BookingInitial());
  }
}
