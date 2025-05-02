import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/api/domain/entities/service.dart';

class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key, required this.services});

  final List<Services> services;

  void _onSelectService(BuildContext context, String serviceName) {
    context.router.pushNamed('/booking');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: services.map((service) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Card(
                elevation: 3,
                // Увеличил elevation для большей заметности
                shadowColor: theme.shadowColor.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: theme.colorScheme.surfaceContainerHighest,
                // Более заметный фон
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.service_name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${service.duration} минут",
                              style: theme.textTheme.displaySmall,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _onSelectService(context, service.id),
                        style: theme.elevatedButtonTheme.style,
                        child: Text(
                          "${service.price} ₽",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
