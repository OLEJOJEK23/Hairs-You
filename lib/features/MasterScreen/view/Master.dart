import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/widgets/ImageScroll.dart';

@RoutePage()
class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  // Sample data for the master (replace with your actual data source)
  final Map<String, dynamic> master = {
    'fullName': 'Анна Иванова',
    'photos': [
      'assets/images/google_logo.png',
      'assets/images/google_logo.png',
      'assets/images/google_logo.png',
    ],
    'description': 'Специалист по стрижкам и окраани Оrite',
    'isFavorite': false,
  };

  void _toggleFavorite() {
    setState(() {
      master['isFavorite'] = !master['isFavorite'];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          master['isFavorite']
              ? '${master['fullName']} добавлен в избранное'
              : '${master['fullName']} удалён из избранного',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _selectMaster() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Выбран мастер: ${master['fullName']}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          master['fullName'],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: theme.scaffoldBackgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceContainerLow.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Scrollable list of photos with indicator
                ImageScroll(
                  imageUrls: master["photos"],
                ),
                const SizedBox(height: 16),
                // Full name
                Text(
                  master['fullName'],
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                // Description
                Text(
                  master['description'],
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        master['isFavorite']
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: master['isFavorite']
                            ? Colors.redAccent
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                    ElevatedButton(
                      onPressed: _selectMaster,
                      style: theme.elevatedButtonTheme.style,
                      child: Text(
                        'Выбрать',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
