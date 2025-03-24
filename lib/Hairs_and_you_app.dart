import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hairs_and_you/blocks/theme_block/theme_cubit.dart';
import 'package:hairs_and_you/repositories/settings_repository/settings.dart';
import 'package:hairs_and_you/router/router.dart';
import 'package:hairs_and_you/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HairsAndYouApp extends StatefulWidget {
  const HairsAndYouApp({
    super.key,
    required this.sharedPreferences
  });

  final SharedPreferences sharedPreferences;

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
    final settingsRepository = SettingsRepository(sharedPreferences: widget.sharedPreferences);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ThemeCubit(
                   settingsRepository: settingsRepository,
                )
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Hairs&You',
            theme: state.isDark ? darkTheme : lightTheme,
            routerConfig: _router.config(),
          );
        },
      ),
    );
  }
}