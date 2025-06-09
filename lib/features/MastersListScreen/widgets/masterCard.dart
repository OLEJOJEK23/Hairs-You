import 'package:flutter/material.dart';
import 'package:hairs_and_you/api/domain/entities/master.dart';
import 'package:hairs_and_you/widgets/FavoriteButtonWidget.dart';

class MasterCard extends StatefulWidget {
  final Master master;
  final int index;
  final VoidCallback onSelectMaster;

  const MasterCard({
    super.key,
    required this.master,
    required this.index,
    required this.onSelectMaster,
  });

  @override
  State<MasterCard> createState() => _MasterCardState();
}

class _MasterCardState extends State<MasterCard> {
  bool favorite = false;

  @override
  void initState() {
    setState(() {
      favorite = widget.master.isFavorite;
    });
    super.initState();
  }

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
          widget.index == 0
              ? SizedBox(
                  height: 180, // Высота фото
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/master1.jpg",
                    fit: BoxFit.cover,
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
                )
              : SizedBox(
                  height: 180, // Высота фото
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/master2.jpg",
                    fit: BoxFit.cover,
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
                        widget.master.fullName,
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    FavoriteButton(
                      type: "master",
                      id: widget.master.id,
                      initialFavorite: widget.master.isFavorite,
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Опыт: ${widget.master.experience}',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.master.description == null
                      ? "описания нет"
                      : widget.master.description!,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                // Кнопка "Выбрать"
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: widget.onSelectMaster,
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
