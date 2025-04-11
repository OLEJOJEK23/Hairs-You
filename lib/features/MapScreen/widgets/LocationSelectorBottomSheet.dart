import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocationSelectorBottomSheet extends StatefulWidget {
  const LocationSelectorBottomSheet({super.key, required this.onConfirm});

  final Function(String) onConfirm; // Изменён тип на String для передачи адреса

  @override
  State<LocationSelectorBottomSheet> createState() =>
      _LocationSelectorBottomSheetState();
}

class _LocationSelectorBottomSheetState
    extends State<LocationSelectorBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];
  String _selectedAddress = '';
  static const String _apiKey = 'AIzaSyBgy6Dza_gIvk2IcaeItlOU9ZBwl1CykL4';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Получение автодополнений от Google Places API
  Future<void> _fetchSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }

    const String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final String requestUrl =
        '$baseUrl?input=$input&types=address&language=ru&key=$_apiKey';

    try {
      final response = await http.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> predictions = data['predictions'];
        setState(() {
          _suggestions = predictions
              .map<String>((prediction) => prediction['description'] as String)
              .toList();
        });
      } else {
        _showError('Ошибка загрузки предложений');
      }
    } catch (e) {
      _showError('Ошибка запроса: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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
          // Drag Handle
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
          const SizedBox(height: 16),
          // Поле поиска
          Container(
            height: 60,
            margin: const EdgeInsets.only(right: 5),
            child: TextField(
              controller: _searchController,
              style: theme.textTheme.labelLarge,
              decoration: InputDecoration(
                labelText: "Адрес",
                hintText: 'Введите город, улицу или адрес',
                prefixIcon: const Icon(Icons.search),
                hintStyle: theme.textTheme.bodyMedium,
                labelStyle: theme.textTheme.labelLarge,
                focusedBorder: theme.inputDecorationTheme.focusedBorder,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _searchController.clear(); // Очищаем поле ввода
                            _selectedAddress = ''; // Сбрасываем выбранный адрес
                            _suggestions = []; // Очищаем предложения
                          });
                        },
                      )
                    : null,
                border: theme.inputDecorationTheme.border,
              ),
              onChanged: (value) {
                _fetchSuggestions(value); // Запрос автодополнений при вводе
                setState(() {
                  _selectedAddress = value; // Сохраняем введённый текст
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          // Список предложений
          Expanded(
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = _suggestions[index];
                return ListTile(
                  title: Text(
                    suggestion,
                    style: theme.textTheme.bodyMedium,
                  ),
                  onTap: () {
                    setState(() {
                      _searchController.text = suggestion;
                      _selectedAddress = suggestion;
                      _suggestions = []; // Скрываем предложения после выбора
                    });
                  },
                );
              },
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedAddress.isNotEmpty
                    ? () {
                        widget.onConfirm(_selectedAddress);
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
