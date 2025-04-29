import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../api/domain/entities/suggestion.dart';
import '../../../api/domain/usecases/get_place_suggestions.dart';

class LocationSelectorBottomSheet extends StatefulWidget {
  const LocationSelectorBottomSheet({super.key, required this.onConfirm});

  final Function(String) onConfirm;

  @override
  State<LocationSelectorBottomSheet> createState() =>
      _LocationSelectorBottomSheetState();
}

class _LocationSelectorBottomSheetState
    extends State<LocationSelectorBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Suggestion> _suggestions = [];
  String _selectedAddress = '';

  // Получаем use case через GetIt
  final GetPlaceSuggestions _getPlaceSuggestions =
      GetIt.I<GetPlaceSuggestions>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Получение автодополнений
  Future<void> _fetchSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }

    final result = await _getPlaceSuggestions(input);
    result.fold(
      (failure) => _showError(failure.message),
      (suggestions) => setState(() {
        _suggestions = suggestions;
      }),
    );
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
          SizedBox(
            height: 60,
            child: TextField(
              controller: _searchController,
              style: theme.textTheme.labelLarge,
              decoration: InputDecoration(
                labelText: "Адрес",
                hintText: 'Введите город, улицу или адрес',
                prefixIcon: const Icon(Icons.search),
                hintStyle: theme.textTheme.labelLarge,
                labelStyle: theme.textTheme.labelLarge,
                focusedBorder: theme.inputDecorationTheme.focusedBorder,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _selectedAddress = '';
                            _suggestions = [];
                          });
                        },
                      )
                    : null,
                border: theme.inputDecorationTheme.border,
              ),
              onChanged: (value) {
                _fetchSuggestions(value);
                setState(() {
                  _selectedAddress = value;
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
                    suggestion.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                  leading: const Icon(Icons.location_on),
                  onTap: () {
                    setState(() {
                      _searchController.text = suggestion.description;
                      _selectedAddress = suggestion.description;
                      _suggestions = [];
                    });
                  },
                );
              },
            ),
          ),
          TextButton(
            onPressed: () async {
              final address = await context.router.pushNamed("/map");
              if (address != null && address is String) {
                setState(() {
                  _selectedAddress = address;
                  _searchController.text = address;
                });
              }
            },
            child: Text(
              "Выбрать на карте",
              style: theme.textTheme.bodyMedium,
            ),
          ),
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
