import 'package:flutter/material.dart';
import 'package:hairs_and_you/controllers/Auth_contoroller.dart';
import '../../LoginScreen/LoginScreen.dart';

class HomeScreen extends  StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
          child: Center(
            child: ElevatedButton(
                onPressed: () {
                  PhoneAuthController.signOut();
                  Navigator.of(context).push( MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
                child: const Text("LogOut"))
          )
        ),
    );
  }
}