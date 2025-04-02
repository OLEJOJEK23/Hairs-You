import 'package:flutter/material.dart';

class RatingDisplay extends StatelessWidget {
  const RatingDisplay({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: rating >= 4
            ? Colors.green.withOpacity(0.9)
            : rating >= 3
                ? Colors.orange.withOpacity(0.9)
                : Colors.red.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            rating.toString(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.star,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
