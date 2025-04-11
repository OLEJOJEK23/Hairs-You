import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'LocationSelectorBottomSheet.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  String _text = "";

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
            child: LocationSelectorBottomSheet(
              onConfirm: (String address) {
                setState(() {
                  _text = address;
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 5),
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
                  const Icon(Icons.place),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _text.isEmpty ? "Место" : _text,
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
