import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MapScreen extends  StatefulWidget {
  const MapScreen({super.key});


  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text("map")
        )
      )
    );
  }
}