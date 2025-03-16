import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AIScreen extends StatefulWidget {
  const AIScreen({super.key});


  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  const  Scaffold(
        body: SafeArea(
            child: Center(
                child:   Text("AI"))
        )
    );
  }
}