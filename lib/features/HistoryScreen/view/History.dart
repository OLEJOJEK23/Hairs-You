import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryState();
}

class _HistoryState extends State<HistoryScreen> {
  // Sample data for generated images history
  final List<Map<String, dynamic>> _history = [
    {
      'image': 'assets/images/google_logo.png', // Replace with actual image path
      'parameters': 'Параметры 1',
      'dateTime': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'image': 'assets/images/google_logo.png', // Replace with actual image path
      'parameters': 'Параметры 2',
      'dateTime': DateTime.now().subtract(const Duration(hours: 5)),
    },
    {
      'image': 'assets/images/google_logo.png', // Replace with actual image path
      'parameters': 'Параметры 3',
      'dateTime': DateTime.now().subtract(const Duration(minutes: 30)),
    },
    {
      'image': 'assets/images/google_logo.png', // Replace with actual image path
      'parameters': 'Параметры 4',
      'dateTime': DateTime.now(),
    },
  ];

  void _goToDetails(Map<String, dynamic> item) {
    // Implement navigation to details screen here
    // For example: context.router.push(DetailsRoute(item: item));
    // ignore: avoid_print
    print("Go to details for: ${item['parameters']}");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("История"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _history.isEmpty
            ? Center(
          child: Text(
            "История пуста",
            style: TextStyle(color: theme.hintColor, fontSize: 16),
          ),
        )
            : ListView.separated(
          itemCount: _history.length,
          separatorBuilder: (context, index) =>
          const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = _history[index];
            return HistoryCard(
              imagePath: item['image'],
              parameters: item['parameters'],
              dateTime: item['dateTime'],
              onDetailsPressed: () => _goToDetails(item),
            );
          },
        ),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String imagePath;
  final String parameters;
  final DateTime dateTime;
  final VoidCallback onDetailsPressed;

  const HistoryCard({
    super.key,
    required this.imagePath,
    required this.parameters,
    required this.dateTime,
    required this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
            const SizedBox(height: 12),
            // Parameters
            Text(
              parameters,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Date and Time
            Text(
              "dd.MM.yyyy HH:mm",
              style: TextStyle(fontSize: 14, color: theme.hintColor),
            ),
            const SizedBox(height: 12),
            // Details Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onDetailsPressed,
                child: const Text("Подробнее"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}