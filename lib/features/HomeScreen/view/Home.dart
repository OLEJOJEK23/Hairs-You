import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
          ProfileRoute(),
        ],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            body: child,
            bottomNavigationBar: GNav(
              gap: 5,
              rippleColor: Colors.grey.shade300, // Цвет при нажатии
              selectedIndex: tabsRouter.activeIndex,
              padding: const EdgeInsets.all(20),
              color: theme.hintColor,
              activeColor: theme.primaryColor,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Главная',
                ),
                GButton(
                  icon: Icons.map,
                  text: 'Запись',
                ),
                GButton(
                  icon: Icons.biotech,
                  text: 'Генерация',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Профиль',
                ),
              ],
              onTabChange: (index) => _openPage(index, tabsRouter),
            ),
          );
        },
    );
  }
}