import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hairs_and_you/blocks/theme_block/theme_cubit.dart';
import 'package:hairs_and_you/router/router.dart';
import 'package:hairs_and_you/theme/theme.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ThemeCubit(
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