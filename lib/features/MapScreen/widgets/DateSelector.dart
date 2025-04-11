import 'package:flutter/material.dart';
import 'package:hairs_and_you/features/MapScreen/widgets/DateSelectorBottomSheet.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  String _text = "";

  String formatDate(DateTime date) {
    String formatedText = "";
    if (date.year != DateTime.now().year) {
      formatedText = DateFormat('dd.MM.yyyy').format(date);
    } else {
      formatedText = DateFormat('dd.MM').format(date);
    }
    return formatedText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: DateSelectorBottomSheet(
              onConfirm: (DateTime selectedDate, String selectedCategory) {
                setState(() {
                  _text = '${formatDate(selectedDate)}, $selectedCategory';
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        padding: const EdgeInsets.all(10),
        decoration: theme.brightness == Brightness.light
            ? boxDecorationLight
            : boxDecorationDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _text.isEmpty ? "Дата" : _text,
                      style: theme.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            if (_text.isNotEmpty) // Показываем крестик только если есть текст
              GestureDetector(
                onTap: () {
                  setState(() {
                    _text = ""; // Сбрасываем текст
                  });
                },
                child: const Icon(
                  Icons.clear,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
