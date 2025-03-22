import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/router/router.dart';
import 'package:hairs_and_you/theme/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HairsAndYouApp());
}

class HairsAndYouApp extends StatefulWidget {
  const HairsAndYouApp({super.key});


  @override
  State<HairsAndYouApp> createState() => _HairsAndYouAppState();
}

class _HairsAndYouAppState extends State<HairsAndYouApp> {

  final _router = AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Hairs&You',
      theme: darkTheme,
      routerConfig: _router.config(),
    );
  }
}