class Master {
  Master({
    required this.fullName,
    required this.description,
    required this.experience,
    required this.createdAt,
    required this.id,
    required this.isFavorite,
    required this.photoURL,
  });

  final String fullName;
  final String? description;
  final String experience;
  final String id;
  final bool isFavorite;
  final String photoURL;
  final String createdAt;
}
