import 'package:flutter/material.dart';

import '../../../widgets/CalendarWidget.dart';

class DateSelectorBottomSheet extends StatefulWidget {
  const DateSelectorBottomSheet({
    super.key,
  });

  @override
  State<DateSelectorBottomSheet> createState() =>
      _DateSelectorBottomSheetState();
}

class _DateSelectorBottomSheetState extends State<DateSelectorBottomSheet> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  bool _showTooltips = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CalendarWidget(
            selectedDate: _selectedDate,
            focusedDate: _focusedDate,
            onDaySelected: (selectedDay, focusedDay) {
              setState(
                () {
                  _selectedDate = selectedDay;
                  _focusedDate = focusedDay;
                  _showTooltips = true;
                },
              );
            },
          ),
          const SizedBox(height: 16),
          _showTooltips ? const Text("da") : const Text("net"),
        ],
      ),
    );
  }
}
