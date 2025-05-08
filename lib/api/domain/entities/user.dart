class Users {
  Users({
    required this.displayName,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.photoURL,
    required this.rating,
  });

  final String displayName;
  final String? email;
  final String? phone;
  final String photoURL;
  final String createdAt;
  final double rating;
}
