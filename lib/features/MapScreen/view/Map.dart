import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/features/MapScreen/widgets/DateSelector.dart';
import 'package:hairs_and_you/features/MapScreen/widgets/LocationSelector.dart';

import '../../../theme/theme.dart';
import '../../../widgets/SearchWidget.dart';

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
              establishments: [{}],
              onSearch: (_) {},
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
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
                          builder: (context) => Padding(
                            padding: const EdgeInsets.only(top: 80.0),
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
                decoration: boxDecoration,
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DateSelectorBottomSheet extends StatelessWidget {
  const DateSelectorBottomSheet({
    super.key,
  });

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
        children: [
          SizedBox(
            width: double.infinity,
            child: Text("dsa"),
          ),
        ],
      ),
    );
  }
}
