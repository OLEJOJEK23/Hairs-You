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
            title:  Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: boxDecoration,
                child:  Row(
                  children: [
                    const Icon(Icons.search),
                    const SizedBox(width: 12),
                    Text(
                      "Поиск услуг",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                )
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.all(5).copyWith(left: 16).copyWith(bottom: 9),
                        padding: const EdgeInsets.all(10),
                        decoration: boxDecoration,
                        child:  Row(
                          children: [
                            const Icon(Icons.place),
                            const SizedBox(width: 12),
                            Text(
                              "Место" ,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        )
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.all(5).copyWith(right: 16).copyWith(bottom: 9),
                        padding: const EdgeInsets.all(10),
                        decoration: boxDecoration,
                        child:  Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(width: 12),
                            Text(
                              "Дата",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final types = ["Все", "Барбершоп", "Салон красоты", "Парикмахерская"];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: boxDecoration,
                    child: Center(
                      child: Text(
                        types[index],
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 100,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) => Container(
                  height: 100,
                  decoration: boxDecoration,
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}
