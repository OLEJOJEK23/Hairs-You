import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HistoryScreen extends  StatefulWidget {
  const HistoryScreen({super.key});


  @override
  State<HistoryScreen> createState() => _HistoryState();
}

class _HistoryState extends State<HistoryScreen> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("История"),
        centerTitle: true,
      ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
                child: Text("История")
            )
        )
    );
  }
}