import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/entities/salonsTypes.dart';
import 'package:hairs_and_you/api/domain/usecases/get_salons_types.dart';
import 'package:hairs_and_you/features/RecordScreen/widgets/DateSelector.dart';
import 'package:hairs_and_you/features/RecordScreen/widgets/LocationSelector.dart';

import '../../../api/domain/entities/shortSalon.dart';
import '../../../api/domain/usecases/get_short_salons.dart';
import '../../../widgets/OfferCard.dart';
import '../../../widgets/SearchWidget.dart';

@RoutePage()
class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final GetSalonsTypes _getSalonsTypes = GetIt.I<GetSalonsTypes>();
  bool _isSalonsTypesLoading = false;
  final GetShortSalons _getShortSalons = GetIt.I<GetShortSalons>();
  List<ShortSalon> _salons = [];
  List<ShortSalon> _filteredSalons = [];
  String? _salonsTypesError;
  List<SalonsTypes> _categories = [SalonsTypes(type: "Всё", id: 0)];
  bool _isSalonsLoading = false;
  String? _salonsError;

  int _selectedCategory = 0;
  String? _selectedLocation;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _fetchSalonsTypes();
    _fetchSalons();
  }

  Future<void> _fetchSalonsTypes() async {
    setState(() {
      _isSalonsTypesLoading = true;
      _salonsTypesError = null;
    });
    final result = await _getSalonsTypes();
    result.fold(
      (failure) => setState(() {
        _salonsTypesError = failure.message;
        _isSalonsTypesLoading = true;
      }),
      (salonsTypes) => setState(() {
        _categories += salonsTypes;
        _isSalonsTypesLoading = false;
      }),
    );
    if (_salonsTypesError != null) {
      print(_salonsTypesError);
    }
  }

  Future<void> _fetchSalons() async {
    setState(() {
      _isSalonsLoading = true;
      _salonsError = null;
    });
    final result = await _getShortSalons();
    result.fold(
      (failure) => setState(() {
        _salonsError = failure.message;
        _isSalonsLoading = true;
      }),
      (salons) => setState(() {
        _salons = salons;
        _filteredSalons = _salons;
        _isSalonsLoading = false;
      }),
    );
    if (_salonsError != null) {
      print(_salonsError);
    }
  }

  void _filterSalons() {
    final addressComponents = _parseGoogleAddress(_selectedLocation);
    final streetFilter = addressComponents['street'];
    final cityFilter = addressComponents['city'];
    setState(() {
      _filteredSalons = _salons.where((salon) {
        // Фильтр по категории
        bool categoryMatch =
            _selectedCategory == 0 || salon.typeID == _selectedCategory;
        // Фильтр по адресу
        bool locationMatch = _selectedLocation == null ||
            // Проверка полного адреса (ручной ввод или частичное совпадение)
            (salon.city_name
                    .toLowerCase()
                    .contains(_selectedLocation!.toLowerCase()) ||
                salon.address
                    .toLowerCase()
                    .contains(_selectedLocation!.toLowerCase())) ||
            // Проверка города
            (cityFilter != null &&
                salon.city_name
                    .toLowerCase()
                    .contains(cityFilter.toLowerCase())) ||
            // Проверка улицы и дома
            (streetFilter != null &&
                salon.address
                    .toLowerCase()
                    .contains(streetFilter.toLowerCase()));
        return categoryMatch && locationMatch;
      }).toList();
    });
  }

  // Парсим адрес Google Places на улицу (с номером дома) и город
  Map<String, String?> _parseGoogleAddress(String? address) {
    if (address == null || address.isEmpty) {
      return {
        'street': null,
        'house': null,
        'city': null,
        'region': null,
        'country': null
      };
    }
    final parts = address.split(',').map((part) => part.trim()).toList();
    String? street;
    String? house;
    String? city;

    if (parts.length >= 4) {
      street = parts[0];

      final secondPart = parts[1];
      if (RegExp(r'^(д\.\s*\d+|\d+)$').hasMatch(secondPart)) {
        house = secondPart;
        city = parts[2];
      } else {
        city = secondPart;
      }
    } else if (parts.length == 3) {
      street = parts[0];
      city = parts[1];
    } else if (parts.length == 2) {
      street = parts[0];
      city = parts[1];
    } else {
      city = address;
    }

    return {'street': street, 'house': house, 'city': city};
  }

  void _onOfferTapped(BuildContext context, String id) {
    context.router.pushNamed("/establishment/$id");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: _isSalonsTypesLoading || _isSalonsLoading
          ? Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  snap: true,
                  pinned: true,
                  floating: true,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  title: SearchWidget(
                    establishments: _salons,
                    onSearch: (String? selectedId) {
                      if (selectedId != null) {
                        _onOfferTapped(context, selectedId);
                      }
                    },
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(54),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: LocationSelector(
                              onLocationSelected: (String? location) {
                                setState(() {
                                  _selectedLocation = location;
                                  _filterSalons();
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: DateSelector(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(top: 5),
                  sliver: SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          final isSelected = _selectedCategory == category.id;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ChoiceChip(
                              label: Text(
                                category.type,
                                style: theme.textTheme.titleSmall,
                              ),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedCategory = category.id;
                                });
                                _filterSalons();
                              },
                              selectedColor: theme.primaryColor,
                              labelStyle: TextStyle(
                                color:
                                    isSelected ? Colors.white : theme.hintColor,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(top: 5),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "Найденные заведения (${_filteredSalons.length}):",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.builder(
                    itemCount: _filteredSalons.length,
                    itemBuilder: (context, index) {
                      final offer = _filteredSalons[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            _onOfferTapped(context, offer.id);
                          },
                          child: OfferCard(
                            title: offer.name,
                            description: offer.description,
                            imagePath: "assets/images/google_logo.png",
                            address: "${offer.city_name}, ${offer.address}",
                            rating: offer.rating,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
