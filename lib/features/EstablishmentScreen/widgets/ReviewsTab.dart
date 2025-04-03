import 'package:flutter/material.dart';

import '../../../widgets/RatingDisplay.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key, required this.reviews});

  final List<Map<String, dynamic>> reviews;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: reviews.map((review) {
            return Card(
              elevation: 3,
              // Увеличил elevation для большей заметности
              shadowColor: theme.shadowColor.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review['author'],
                          style: theme.textTheme.titleMedium,
                        ),
                        RatingDisplay(rating: review['rating']),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review['text'],
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review['date'],
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
