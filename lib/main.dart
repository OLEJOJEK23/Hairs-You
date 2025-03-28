import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/controllers/Auth_contoroller.dart';
import 'package:hairs_and_you/controllers/Link_account_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Hairs_and_you_app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  GetIt.I.registerLazySingleton(() => AuthController());
  GetIt.I.registerLazySingleton(() => LinkAccountController());
  runApp(HairsAndYouApp(
    sharedPreferences: sharedPreferences,
  ));
}
