import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5).copyWith(left: 16).copyWith(bottom: 9),
        padding: const EdgeInsets.all(10),
        decoration: boxDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.place),
            const SizedBox(width: 12),
            Text(
              "Место",
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
