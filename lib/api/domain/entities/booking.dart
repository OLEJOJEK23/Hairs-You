class Booking {
  Booking(
      {required this.bookingTime,
      required this.masterID,
      required this.masterName,
      required this.salonAddress,
      required this.salonID,
      required this.salonName,
      required this.salonsCity,
      required this.serviceID,
      required this.serviceName,
      required this.status});

  final String bookingTime;
  final String masterID;
  final String masterName;
  final String salonAddress;
  final String salonID;
  final String salonName;
  final String salonsCity;
  final String serviceID;
  final String serviceName;
  final String status;
}
