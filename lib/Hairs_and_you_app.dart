import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/blocks/theme_block/theme_cubit.dart';
import 'package:hairs_and_you/repositories/settings_repository/settings.dart';
import 'package:hairs_and_you/router/router.dart';
import 'package:hairs_and_you/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HairsAndYouApp extends StatefulWidget {
  const HairsAndYouApp({super.key});

  @override
  State<HairsAndYouApp> createState() => _HairsAndYouAppState();
}

class _HairsAndYouAppState extends State<HairsAndYouApp> {
  final _router = AppRouter();
  final sharedPreferences = GetIt.I.get<SharedPreferences>();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingsRepository = SettingsRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(
            settingsRepository: settingsRepository,
          ),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Hairs&You',
            theme: state.isDark ? darkTheme : lightTheme,
            routerConfig: _router.config(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ru', 'RU'),
              Locale('en', 'US'),
            ],
            locale: const Locale('ru', 'RU'),
          );
        },
      ),
    );
  }
}
