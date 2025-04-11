import 'package:auto_route/auto_route.dart';

import '../Guards/AuthGuard.dart';
import '../features/AIScreen/AIScreen.dart';
import '../features/BookingScreen/BookingScreen.dart';
import '../features/EstablishmentScreen/view/Establishment.dart';
import '../features/FavoriteScreen/FavoriteScreen.dart';
import '../features/HistoryScreen/HistoryScreen.dart';
import '../features/HomeScreen/HomeScreen.dart';
import '../features/LinkPhoneNumberScreen/view/LinkPhoneNumber.dart';
import '../features/LoginScreen/LoginScreen.dart';
import '../features/MapScreen/MapScreen.dart';
import '../features/MasterScreen/MasterScreen.dart';
import '../features/MastersListScreen/MastersListScreen.dart';
import '../features/PrimaryScreen/PrimaryScreen.dart';
import '../features/ProfileScreen/ProfileScreen.dart';
import '../features/RecordScreen/RecordScreen.dart';
import '../features/SettingsScreen/SettingsScreen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            guards: [AuthGuard()],
            page: HomeRoute.page,
            initial: true,
            path: '/',
            children: [
              AutoRoute(
                page: PrimaryRoute.page,
                path: 'primary',
              ),
              AutoRoute(
                page: AIRoute.page,
                path: 'ai',
              ),
              AutoRoute(
                page: RecordRoute.page,
                path: 'map',
              ),
              AutoRoute(
                page: ProfileRoute.page,
                path: 'profile',
              ),
            ]),
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
        ),
        AutoRoute(
          page: FavoriteRoute.page,
          path: '/favorite',
        ),
        AutoRoute(
          page: HistoryRoute.page,
          path: '/history',
        ),
        AutoRoute(
          page: SettingsRoute.page,
          path: '/settings',
        ),
        AutoRoute(
          page: LinkPhoneNumberRoute.page,
          path: '/linkPhoneNumber',
        ),
        AutoRoute(
          page: EstablishmentRoute.page,
          path: '/establishment',
        ),
        AutoRoute(
          page: BookingRoute.page,
          path: '/booking',
        ),
        AutoRoute(
          page: MastersListRoute.page,
          path: '/masters',
        ),
        AutoRoute(
          page: MasterRoute.page,
          path: '/master',
        ),
        AutoRoute(
          page: MapRoute.page,
          path: '/master',
        ),
      ];
}
