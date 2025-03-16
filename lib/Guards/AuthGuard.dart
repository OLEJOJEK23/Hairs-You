import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../router/router.dart';

class AuthGuard extends AutoRouteGuard {
  User? user;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      resolver.next(true);
    } else {
      router.push(const LoginRoute());
    }
  }
}
