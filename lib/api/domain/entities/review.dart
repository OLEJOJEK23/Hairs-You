class Review {
  Review({
    required this.display_name,
    required this.text,
    required this.rating,
    required this.created_at,
  });

  final String display_name;
  final String text;
  final double rating;
  final DateTime created_at;
}
