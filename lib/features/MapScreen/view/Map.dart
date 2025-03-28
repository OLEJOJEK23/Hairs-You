import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

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
            title: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: boxDecoration,
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(width: 12),
                      Text(
                        "Поиск услуг",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.all(5)
                            .copyWith(left: 16)
                            .copyWith(bottom: 9),
                        padding: const EdgeInsets.all(10),
                        decoration: boxDecoration,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.place),
                            const SizedBox(width: 12),
                            Text(
                              "Место",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.all(5)
                            .copyWith(right: 16)
                            .copyWith(bottom: 9),
                        padding: const EdgeInsets.all(10),
                        decoration: boxDecoration,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(width: 12),
                            Text(
                              "Дата",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        )),
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
                ""
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
