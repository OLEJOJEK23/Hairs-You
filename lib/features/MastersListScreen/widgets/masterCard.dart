import 'package:flutter/material.dart';
import 'package:hairs_and_you/api/domain/entities/master.dart';

class MasterCard extends StatelessWidget {
  final Master master;
  final int index;
  final VoidCallback onSelectMaster;
  final Function(int) onToggleFavorite;

  const MasterCard({
    super.key,
    required this.master,
    required this.index,
    required this.onSelectMaster,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: theme.colorScheme.surfaceContainer,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180, // Высота фото
            width: double.infinity,
            child: Image.asset(
              "assets/images/google_logo.png",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                color: theme.colorScheme.surfaceContainerHigh,
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              ),
            ),
          ),
          // Информация о мастере
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        master.fullName,
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        master.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: master.isFavorite
                            ? Colors.redAccent
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () => onToggleFavorite(index),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Опыт: ${master.experience}',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  master.description == null
                      ? "описания нет"
                      : master.description!,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                // Кнопка "Выбрать"
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: onSelectMaster,
                    style: theme.elevatedButtonTheme.style,
                    child: Text(
                      'Подробнее',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
