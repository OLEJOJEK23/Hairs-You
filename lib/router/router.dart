import 'package:auto_route/auto_route.dart';
import '../Guards/AuthGuard.dart';
import '../features/AIScreen/AIScreen.dart';
import '../features/FavoriteScreen/FavoriteScreen.dart';
import '../features/HomeScreen/HomeScreen.dart';
import '../features/LoginScreen/LoginScreen.dart';
import '../features/MapScreen/MapScreen.dart';
import '../features/ProfileScreen/ProfileScreen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      guards: [AuthGuard()],
      page: HomeRoute.page,
      path: '/',
    ),
    AutoRoute(
      page: AIRoute.page,
      path: '/ai',
    ),
    AutoRoute(
      page: MapRoute.page,
      path: '/map',
    ),
    AutoRoute(
      page: FavoriteRoute.page,
      path: '/favorite',
    ),
    AutoRoute(
      page: ProfileRoute.page,
      path: '/profile',
    ),
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
    ),
  ];
}