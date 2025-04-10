import 'package:flutter/material.dart';

import '../../../widgets/CalendarWidget.dart';

class DateSelectorBottomSheet extends StatefulWidget {
  const DateSelectorBottomSheet({super.key});

  @override
  State<DateSelectorBottomSheet> createState() =>
      _DateSelectorBottomSheetState();
}

class _DateSelectorBottomSheetState extends State<DateSelectorBottomSheet> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  bool _showTooltips = false;
  bool _enableButton = false;

  final List<String> _categories = ["Любое время", "Утро", "День", "Вечер"];

  String _selectedCategory = "Любое время";

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
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          CalendarWidget(
            selectedDate: _selectedDate,
            focusedDate: _focusedDate,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
                _showTooltips = true;
                _enableButton = true;
              });
            },
          ),
          const SizedBox(height: 16),
          _showTooltips
              ? Wrap(
                  spacing: 10, // Горизонтальный отступ между чипами
                  runSpacing: 10, // Вертикальный отступ между строками
                  children: _categories.map((category) {
                    final isSelected = _selectedCategory == category;
                    return ChoiceChip(
                      label: Text(
                        category,
                        style: theme.textTheme.bodySmall,
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      selectedColor: theme.primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : theme.hintColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox.shrink(),
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _enableButton
                    ? () {
                        Navigator.pop(context);
                      }
                    : null,
                child: const Text(
                  "Подтвердить",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
