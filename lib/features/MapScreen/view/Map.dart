import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/features/MapScreen/widgets/DateSelector.dart';
import 'package:hairs_and_you/features/MapScreen/widgets/LocationSelector.dart';

import '../../../theme/theme.dart';
import '../../../widgets/SearchWidget.dart';
import '../widgets/DateSelectorBottomSheet.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<String> _categories = [
    "Всё",
    "Барбершоп",
    "Парикмахерская",
    "Салон красоты",
    "Массаж",
    "Солярий",
    "Другое",
  ];

  String _selectedCategory = "Всё";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            pinned: true,
            floating: true,
            surfaceTintColor: Colors.transparent,
            backgroundColor: theme.scaffoldBackgroundColor,
            title: SearchWidget(
              establishments: const [{}],
              onSearch: (_) {},
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(54),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: LocationSelector(
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: DateSelector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => const Padding(
                              padding: EdgeInsets.only(top: 100.0),
                              child: DateSelectorBottomSheet(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 5),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ChoiceChip(
                        label: Text(
                          category,
                          style: theme.textTheme.titleSmall,
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                          // TODO: Implement filtering logic here
                        },
                        selectedColor: theme.primaryColor,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : theme.hintColor,
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
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 5),
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
