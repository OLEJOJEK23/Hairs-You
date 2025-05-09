import 'package:flutter/material.dart';

import '../../../widgets/RatingDisplay.dart';

class FavoriteCard extends StatelessWidget {
  final String name;
  final String address;
  final double? rating;
  final String imagePath;
  final String? experience;
  final VoidCallback onRemove;
  final VoidCallback onClick;

  const FavoriteCard({
    super.key,
    required this.name,
    required this.onClick,
    required this.address,
    this.rating,
    required this.imagePath,
    required this.onRemove,
    this.experience,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onClick,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 16),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    experience == null
                        ? RatingDisplay(rating: rating!)
                        : Text(
                            experience!,
                            style: theme.textTheme.bodySmall,
                          ),
                  ],
                ),
              ),
              // Remove Button
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: Colors.redAccent,
                onPressed: onRemove,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
