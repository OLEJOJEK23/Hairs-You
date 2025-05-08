import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/blocks/theme_block/theme_cubit.dart';

import '../../../controllers/Link_account_controller.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isHistorySavingEnabled = true;
  bool themeProvider = true;
  bool _isPhoneLinked = false;
  bool _isGoogleLinked = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    user = _auth.currentUser;
    if (user?.phoneNumber != null && user?.phoneNumber != "") {
      _isPhoneLinked = true;
    }
    if (user?.email != null && user?.email != "") {
      _isGoogleLinked = true;
    }
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
              leading: const Icon(
                Icons.dark_mode,
              ),
              title: Text(
                "Включить тёмную тему",
                style: theme.textTheme.labelLarge,
              ),
              trailing: Switch(
                value: isDarkTheme,
                onChanged: (value) {
                  setState(() {
                    context.read<ThemeCubit>().changeTheme(
                        value ? Brightness.dark : Brightness.light);
                  });
                },
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
              ),
            ),
            // History Saving Switch
            ListTile(
              leading: const Icon(Icons.history),
              title:
                  Text("Сохранять историю", style: theme.textTheme.labelLarge),
              trailing: Switch(
                value: _isHistorySavingEnabled,
                onChanged: (value) {
                  setState(() {
                    _isHistorySavingEnabled = value;
                  });
                },
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            Text(
              "Способы входа",
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Телефон"),
              trailing: _isPhoneLinked
                  ? const Icon(Icons.check, color: Colors.green)
                  : ElevatedButton(
                      onPressed: () async {
                        context.router.replaceNamed("/linkPhoneNumber");
                      },
                      child: const Text("Связать"),
                    ),
            ),
            // Google Linking
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Google"),
              trailing: _isGoogleLinked
                  ? const Icon(Icons.check, color: Colors.green)
                  : ElevatedButton(
                      onPressed: () async {
                        await GetIt.I<LinkAccountController>()
                            .linkWithGoogle(context);
                      },
                      child: const Text("Связать"),
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
