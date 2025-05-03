import 'package:flutter/material.dart';
import 'package:hairs_and_you/api/domain/entities/review.dart';
import 'package:intl/intl.dart';

import '../../../widgets/RatingDisplay.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key, required this.reviews});

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: reviews.map((review) {
            DateFormat formatter = DateFormat('dd.MM.yyyy HH:mm');
            String formattedDate = formatter.format(review.created_at);
            return Card(
              elevation: 3,
              // Увеличил elevation для большей заметности
              shadowColor: theme.shadowColor.withValues(alpha: 0.3),
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
                          review.display_name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        RatingDisplay(rating: review.rating),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.text,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formattedDate,
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
