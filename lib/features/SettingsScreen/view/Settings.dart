import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsScreen extends  StatefulWidget {
  const SettingsScreen({super.key});


  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Настройки"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
                child: Text("Настройки")
            )
        )
    );
  }
}