import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/entities/salonsTypes.dart';
import 'package:hairs_and_you/api/domain/usecases/get_salons_types.dart';
import 'package:hairs_and_you/features/RecordScreen/widgets/DateSelector.dart';
import 'package:hairs_and_you/features/RecordScreen/widgets/LocationSelector.dart';

import '../../../theme/theme.dart';

@RoutePage()
class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final GetSalonsTypes _getSalonsTypes = GetIt.I<GetSalonsTypes>();
  bool _isSalonsTypesLoading = false;
  String? _salonsTypesError;
  List<SalonsTypes> _categories = [SalonsTypes(type: "Всё", id: 0)];

  int _selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    _fetchSalonsTypes();
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: _isSalonsTypesLoading
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
                  //title: SearchWidget(
                  //establishments: const [{}],
                  //onSearch: (_) {},
                  //),
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
                                // TODO: Implement filtering logic here
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
                      "Найденные заведения (1324):",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => Container(
                      height: 300,
                      decoration: theme.brightness == Brightness.light
                          ? boxDecorationLight
                          : boxDecorationDark,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
