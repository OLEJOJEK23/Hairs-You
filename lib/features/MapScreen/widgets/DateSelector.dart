import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.calendar_month),
            const SizedBox(width: 12),
            Text(
              "Дата",
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
