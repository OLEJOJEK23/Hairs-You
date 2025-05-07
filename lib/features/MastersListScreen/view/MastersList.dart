import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MastersListScreen extends StatefulWidget {
  const MastersListScreen({super.key});

  @override
  State<MastersListScreen> createState() => _MastersListScreenState();
}

class _MastersListScreenState extends State<MastersListScreen> {
  @override
  void initState() {
    super.initState();
  }

  final List<Map<String, dynamic>> masters = [
    {
      'fullName': 'Анна Иванова',
      'experience': '5 лет',
      'photo': 'assets/images/google_logo.png',
      'description': 'Специалист по стрижкам и окрашиванию.',
      'isFavorite': false,
    },
    {
      'fullName': 'Дмитрий Петров',
      'experience': '8 лет',
      'photo': 'assets/images/google_logo.png',
      'description': 'Мастер классического и современного маникюра.',
      'isFavorite': true,
    },
    {
      'fullName': 'Елена Смирнова',
      'experience': '3 года',
      'photo': 'assets/images/google_logo.png',
      'description': 'Эксперт по уходу за кожей и макияжу.',
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
    context.router.pushNamed('/master');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Выбор мастера',
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
              theme.colorScheme.surfaceContainerLow.withValues(alpha: 0.8),
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
                  horizontal: 16.0,
                  vertical: 5.0,
                ),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: theme.colorScheme.surfaceContainer,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 180, // Высота фото
                        width: double.infinity,
                        child: Image.asset(
                          master['photo'],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: theme.colorScheme.surfaceContainerHigh,
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Информация о мастере
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    master['fullName'],
                                    style: theme.textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onSurface,
                                    ),
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
                            const SizedBox(height: 8),
                            Text(
                              'Опыт: ${master['experience']}',
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              master['description'],
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            // Кнопка "Выбрать"
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () =>
                                    _selectMaster(master['fullName']),
                                style: theme.elevatedButtonTheme.style,
                                child: Text(
                                  'Подробнее',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
