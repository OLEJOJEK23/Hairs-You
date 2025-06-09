import 'package:flutter/material.dart';
import 'package:hairs_and_you/widgets/FavoriteButtonWidget.dart';

import '../../../widgets/RatingDisplay.dart';

class FavoriteCard extends StatefulWidget {
  final String name;
  final String address;
  final double? rating;
  final String imagePath;
  final String? experience;
  final String type;
  final String id;
  final VoidCallback onClick;

  const FavoriteCard({
    super.key,
    required this.name,
    required this.onClick,
    required this.address,
    this.rating,
    required this.imagePath,
    required this.type,
    required this.id,
    this.experience,
  });

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  bool favorite = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.onClick,
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
                  widget.imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
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
                      widget.name,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.address,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    widget.experience == null
                        ? RatingDisplay(rating: widget.rating!)
                        : Text(
                            widget.experience!,
                            style: theme.textTheme.bodySmall,
                          ),
                  ],
                ),
              ),
              // Remove Button
              FavoriteButton(
                type: widget.type,
                id: widget.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
