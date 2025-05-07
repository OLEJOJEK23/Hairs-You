import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/entities/shortSalon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchWidget extends StatefulWidget {
  final List<ShortSalon> establishments;
  final Function(String?) onSearch;
  final String hintText;

  const SearchWidget({
    super.key,
    required this.establishments,
    required this.onSearch,
    this.hintText = "Введите название заведения",
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final SearchController _searchController = SearchController();
  List<String> _searchHistory = [];
  SharedPreferences _prefs = GetIt.I.get<SharedPreferences>();

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSearchHistory() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory = _prefs.getStringList('searchHistory') ?? [];
    });
  }

  Future<void> _saveSearchHistory() async {
    await _prefs.setStringList('searchHistory', _searchHistory);
  }

  void _addToSearchHistory(String query) {
    if (query.trim().isEmpty) return;
    if (_searchHistory.contains(query)) {
      _searchHistory.remove(query);
    }
    _searchHistory.insert(0, query);
    if (_searchHistory.length > 10) {
      _searchHistory.removeLast();
    }
    _saveSearchHistory();
  }

  List<ShortSalon> _filterEstablishments(String query) {
    if (query.trim().isEmpty) {
      return widget.establishments;
    }
    return widget.establishments.where((establishment) {
      final title = establishment.name.toLowerCase();
      final address = establishment.address.toLowerCase();
      final searchQuery = query.toLowerCase();
      return title.contains(searchQuery) || address.contains(searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ExcludeFocus(
          child: SearchAnchor(
            headerTextStyle: theme.textTheme.bodyLarge,
            viewBackgroundColor: theme.scaffoldBackgroundColor,
            searchController: _searchController,
            viewOnSubmitted: (String value) {
              final filtered = _filterEstablishments(value);
              final selectedId = filtered.isNotEmpty ? filtered.first.id : null;
              widget.onSearch(selectedId);
              _addToSearchHistory(value);
              _searchController.closeView(value);
            },
            builder: (BuildContext context, SearchController controller) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SearchBar(
                  controller: controller,
                  hintText: widget.hintText,
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  trailing: <Widget>[
                    controller.text.isNotEmpty
                        ? Tooltip(
                            message: 'Clear',
                            child: IconButton(
                              isSelected: controller.text.isNotEmpty,
                              onPressed: () {
                                setState(() {
                                  controller.clear();
                                });
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              final filteredEstablishments =
                  _filterEstablishments(controller.text);
              return [
                if (controller.text.isEmpty) ...[
                  if (_searchHistory.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "История поиска",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  for (final historyItem in _searchHistory)
                    ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(historyItem),
                      onTap: () {
                        _searchController.text = historyItem;
                        final filtered = _filterEstablishments(historyItem);
                        final selectedId =
                            filtered.isNotEmpty ? filtered.first.id : null;
                        controller.closeView(historyItem);
                        widget.onSearch(selectedId);
                      },
                    ),
                ] else ...[
                  for (final establishment in filteredEstablishments)
                    ListTile(
                      title: Text(establishment.name),
                      subtitle: Text(
                          "${establishment.city_name}, ${establishment.address}"),
                      onTap: () {
                        controller.closeView(establishment.name);
                        _addToSearchHistory(establishment.name);
                        widget.onSearch(establishment.id); // Возвращаем id
                      },
                    ),
                ],
              ];
            },
          ),
        ),
      ],
    );
  }
}
