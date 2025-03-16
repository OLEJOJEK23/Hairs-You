import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});


  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  const  Scaffold(
        body: SafeArea(
            child: Center(
                child:   Text("Primary"))
        )
    );
  }
}