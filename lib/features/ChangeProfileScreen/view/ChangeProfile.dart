import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChangeProfileScreen extends  StatefulWidget {
  const ChangeProfileScreen({super.key});


  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfileScreen> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Изменение профиля"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
                child: Text("изменение профиля")
            )
        )
    );
  }
}