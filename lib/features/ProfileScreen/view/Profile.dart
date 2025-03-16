import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/controllers/Auth_contoroller.dart';
import '../../LoginScreen/LoginScreen.dart';

@RoutePage()
class ProfileScreen extends  StatefulWidget {
  const ProfileScreen({super.key});


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


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
                    AuthController.signOut();
                    Navigator.of(context).push( MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  },
                  child: const Text("LogOut"))
          )
      ),
    );
  }
}