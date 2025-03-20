import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
              title: const Text("Включить тёмную тему"),
              trailing: Switch(
                value: themeProvider,
                onChanged: (value) {
                  setState(() {
                    themeProvider = value;
                  });
                },
              ),
            ),
            // History Saving Switch
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Сохранять историю"),
              trailing: Switch(
                value: _isHistorySavingEnabled,
                onChanged: (value) {
                  setState(() {
                    _isHistorySavingEnabled = value;
                  });
                },
              ),
            ),
            const Spacer(),
            // App Version
            Center(
              child: Text(
                "Версия приложения: 1.0.0",
                style: TextStyle(color: theme.hintColor),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}