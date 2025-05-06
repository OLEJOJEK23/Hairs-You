class ShortSalon {
  ShortSalon({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.photoURL,
    required this.city_name,
    required this.rating,
    required this.typeID,
  });

  final String id;
  final String name;
  final String description;
  final String address;
  final String photoURL;
  final String city_name;
  final double rating;
  final int typeID;
}
