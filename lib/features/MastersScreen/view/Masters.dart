import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MastersScreen extends StatefulWidget {
  const MastersScreen({super.key});

  @override
  State<MastersScreen> createState() => _MastersScreenState();
}

class _MastersScreenState extends State<MastersScreen> {
  final List<Map<String, dynamic>> masters = [
    {
      'fullName': 'Анна Иванова',
      'experience': '5 лет',
      'photos': [
        'assets/images/google_logo.png',
        'assets/images/google_logo.png',
        'assets/images/google_logo.png',
      ],
      'isFavorite': false,
    },
    {
      'fullName': 'Дмитрий Петров',
      'experience': '8 лет',
      'photos': [
        'assets/images/google_logo.png',
        'assets/images/google_logo.png',
      ],
      'isFavorite': true,
    },
    {
      'fullName': 'Елена Смирнова',
      'experience': '3 года',
      'photos': [
        'assets/images/google_logo.png',
        'assets/images/google_logo.png',
        'assets/images/google_logo.png',
      ],
      'isFavorite': false,
    },
  ];

  void _toggleFavorite(int index) {
    setState(() {
      masters[index]['isFavorite'] = !masters[index]['isFavorite'];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          masters[index]['isFavorite']
              ? '${masters[index]['fullName']} добавлен в избранное'
              : '${masters[index]['fullName']} удалён из избранного',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _selectMaster(String masterName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Выбран мастер: $masterName'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Выбор мастера',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      extendBodyBehindAppBar: true,
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
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            itemCount: masters.length,
            itemBuilder: (context, index) {
              final master = masters[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: theme.colorScheme.surfaceContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ФИО и опыт работы
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    master['fullName'],
                                    style: theme.textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Опыт: ${master['experience']}',
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                master['isFavorite']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: master['isFavorite']
                                    ? Colors.redAccent
                                    : theme.colorScheme.onSurfaceVariant,
                              ),
                              onPressed: () => _toggleFavorite(index),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Список фотографий
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: master['photos'].length,
                            itemBuilder: (context, photoIndex) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    master['photos'][photoIndex],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      width: 120,
                                      height: 120,
                                      color: theme
                                          .colorScheme.surfaceContainerHigh,
                                      child: const Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Кнопка "Выбрать"
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () => _selectMaster(master['fullName']),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              foregroundColor: theme.colorScheme.onPrimary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              textStyle: theme.textTheme.labelLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: const Text('Выбрать'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
