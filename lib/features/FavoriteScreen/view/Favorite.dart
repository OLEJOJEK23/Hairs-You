import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // Sample data for favorite establishments/masters
  final List<Map<String, dynamic>> _favorites = [
    {
      'name': 'У Марии',
      'address': 'Санкт-Петербург, Ленинский проспект 147',
      'rating': 4.8,
      'image': 'assets/images/google_logo.png', // Replace with actual image path
    },
    {
      'name': 'Стрижка',
      'address': 'Санкт-Петербург, Ленинский проспект 148',
      'rating': 4.5,
      'image': 'assets/images/google_logo.png', // Replace with actual image path
    },
    {
      'name': 'Барбершоп',
      'address': 'Санкт-Петербург, Ленинский проспект 149',
      'rating': 4.9,
      'image': 'assets/images/google_logo.png', // Replace with actual image path
    },
    {
      'name': 'Подстирижися',
      'address': 'Санкт-Петербург, Ленинский проспект 1410',
      'rating': 4.2,
      'image': 'assets/images/google_logo.png', // Replace with actual image path
    },
  ];

  void _removeFromFavorites(int index) {
    setState(() {
      _favorites.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _favorites.isEmpty
              ? Center(
            child: Text(
              "Нет избранных заведений",
              style: TextStyle(color: theme.hintColor, fontSize: 16),
            ),
          )
              : ListView.separated(
            itemCount: _favorites.length,
            separatorBuilder: (context, index) =>
            const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final favorite = _favorites[index];
              return FavoriteCard(
                name: favorite['name'],
                address: favorite['address'],
                rating: favorite['rating'],
                imagePath: favorite['image'],
                onRemove: () => _removeFromFavorites(index),
              );
            },
          ),
        ),
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final String name;
  final String address;
  final double rating;
  final String imagePath;
  final VoidCallback onRemove;

  const FavoriteCard({
    super.key,
    required this.name,
    required this.address,
    required this.rating,
    required this.imagePath,
    required this.onRemove,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: TextStyle(fontSize: 14, color: theme.hintColor),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[400]),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Remove Button
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.redAccent,
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}