import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/entities/salonsTypes.dart';
import 'package:hairs_and_you/api/domain/usecases/get_salons_types.dart';
import 'package:hairs_and_you/features/RecordScreen/widgets/DateSelector.dart';
import 'package:hairs_and_you/features/RecordScreen/widgets/LocationSelector.dart';

import '../../../api/domain/entities/shortSalon.dart';
import '../../../api/domain/usecases/get_short_salons.dart';
import '../../../widgets/RatingDisplay.dart';
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
        _filterSalons();
        _isSalonsLoading = false;
      }),
    );
    if (_salonsError != null) {
      print(_salonsError);
    }
  }

  void _filterSalons() {
    setState(() {
      _filteredSalons = _salons.where((salon) {
        // Фильтр по категории
        bool categoryMatch =
            _selectedCategory == 0 || salon.typeID == _selectedCategory;
        return categoryMatch;
      }).toList();
    });
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: LocationSelector(),
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
                      return OfferCard(
                        title: offer.name,
                        description: offer.description,
                        imagePath: "assets/images/google_logo.png",
                        address: "${offer.city_name}, ${offer.address}",
                        rating: offer.rating,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class OfferCard extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final String address;
  final double? rating;
  final VoidCallback? onTap;

  const OfferCard({
    super.key,
    required this.title,
    required this.address,
    required this.description,
    required this.imagePath,
    this.rating,
    this.onTap,
  });

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Изображение с рейтингом
                Stack(
                  children: [
                    Image.asset(
                      widget.imagePath,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 150,
                        color: theme.colorScheme.surface,
                        child: Icon(
                          Icons.broken_image,
                          size: 50,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    // Лёгкий градиент
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.surface.withValues(alpha: 0.3),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                    // Рейтинг
                    if (widget.rating != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: RatingDisplay(
                          rating: widget.rating!,
                        ),
                      ),
                  ],
                ),
                // Контент
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Заголовок
                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Адрес с иконкой
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 20,
                            color: theme.primaryColor,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              widget.address,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Описание
                      Text(
                        widget.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
