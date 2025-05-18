import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/booking.dart';

part 'booking_dto.g.dart';

@JsonSerializable()
class BookingDto {
  BookingDto(
      {required this.booking_time,
      required this.master_id,
      required this.master_name,
      required this.salon_address,
      required this.salon_id,
      required this.salon_name,
      required this.salons_city,
      required this.service_id,
      required this.service_name,
      required this.status});

  final String booking_time;
  final String master_id;
  final String master_name;
  final String salon_address;
  final String salon_id;
  final String salon_name;
  final String salons_city;
  final String service_id;
  final String service_name;
  final String status;

  DateFormat formatter = DateFormat('dd.MM.yyyy HH:mm');

  factory BookingDto.fromJson(Map<String, dynamic> json) =>
      _$BookingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDtoToJson(this);

  Booking toDomain() => Booking(
      bookingTime: formatter.format(DateTime.parse(booking_time)),
      masterID: master_id,
      masterName: master_name,
      salonAddress: salon_address,
      salonID: salon_id,
      salonName: salon_name,
      salonsCity: salons_city,
      serviceID: service_id,
      serviceName: service_name,
      status: status);
}
