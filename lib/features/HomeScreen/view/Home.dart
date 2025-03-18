import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../router/router.dart';

@RoutePage()
class HomeScreen extends  StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  void _openPage(int index, TabsRouter tabsRouter){
    tabsRouter.setActiveIndex(index);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoTabsRouter(
        routes: const [
          PrimaryRoute(),
          MapRoute(),
          AIRoute(),
          FavoriteRoute(),
          ProfileRoute(),
        ],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Hairs&You"),
              centerTitle: true,
            ),
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              unselectedItemColor: theme.hintColor,
              selectedItemColor: theme.primaryColor,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map),
                  label: 'Запись',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.biotech),
                  label: 'Генерация',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Избранное',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Профиль',
                ),
              ],
              onTap: (index) => _openPage(index, tabsRouter),
            ),
          );
        },
    );
  }
}