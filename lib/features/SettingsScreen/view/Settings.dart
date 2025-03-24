import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hairs_and_you/blocks/theme_block/theme_cubit.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isHistorySavingEnabled = true;
  bool themeProvider = true;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = context.watch<ThemeCubit>().state.isDark;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Настройки"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Switch
            ListTile(
              leading: Icon(
                themeProvider == true
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              title:  Text(
                "Включить тёмную тему",
                style: theme.textTheme.labelLarge,
              ),
              trailing: Switch(
                value: isDarkTheme,
                onChanged: (value) {
                  setState(() {
                    context.read<ThemeCubit>().changeTheme(
                        value ? Brightness.dark
                            : Brightness.light
                    );
                  });
                },
                activeTrackColor: Colors.green,
              ),
            ),
            // History Saving Switch
            ListTile(
              leading: const Icon(Icons.history),
              title:  Text(
                  "Сохранять историю",
                  style:theme.textTheme.labelLarge
              ),
              trailing: Switch(
                value: _isHistorySavingEnabled,
                onChanged: (value) {
                  setState(() {
                    _isHistorySavingEnabled = value;
                  });
                },
                activeTrackColor: Colors.green,
              ),
            ),
            const Spacer(),
            // App Version
            Center(
              child: Text(
                "Версия приложения: 1.0.0",
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}