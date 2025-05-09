import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/entities/favorites.dart';
import 'package:hairs_and_you/api/domain/usecases/get_favorites.dart';
import 'package:hairs_and_you/widgets/RatingDisplay.dart';

@RoutePage()
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetFavorites _getFavorites = GetIt.I<GetFavorites>();
  bool _isFavoritesLoading = false;
  String? _favoritesError;
  Favorites? _favorites;

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  void _removeFromFavorites(int index) {}

  Future<void> _fetchFavorites() async {
    setState(() {
      _isFavoritesLoading = true;
      _favoritesError = null;
    });
    final result = await _getFavorites(userID: _auth.currentUser!.uid);
    result.fold(
      (failure) => setState(() {
        _favoritesError = failure.message;
        _isFavoritesLoading = true;
      }),
      (favorites) => setState(() {
        _favorites = favorites;
        _isFavoritesLoading = false;
      }),
    );
    if (_favoritesError != null) {
      print(_favoritesError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Избранное",
          style: theme.textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: _isFavoritesLoading
          ? Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            )
          : _favorites == null ||
                  (_favorites!.favoriteMasters.isEmpty &&
                      _favorites!.favoriteSalons.isEmpty)
              ? Center(
                  child: Text(
                    "Нет избранных заведений",
                    style: theme.textTheme.bodyMedium,
                  ),
                )
              : CustomScrollView(
                  slivers: [
// Мастера
                    if (_favorites!.favoriteMasters.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Text(
                            "Избранные мастера",
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final favorite = _favorites!.favoriteMasters[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: FavoriteCard(
                                name: favorite.name,
                                address: favorite.description,
                                experience: favorite.experience,
                                imagePath: "assets/images/google_logo.png",
                                onRemove: () => _removeFromFavorites(index),
                              ),
                            );
                          },
                          childCount: _favorites!.favoriteMasters.length,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 16),
                      ),
                    ],
                    // Салоны
                    if (_favorites!.favoriteSalons.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Text(
                            "Избранные салоны",
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final favorite = _favorites!.favoriteSalons[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: FavoriteCard(
                                name: favorite.name,
                                address:
                                    "${favorite.cityName}, ${favorite.streetAddress}",
                                rating: favorite.rating,
                                imagePath: "assets/images/google_logo.png",
                                onRemove: () => _removeFromFavorites(index),
                              ),
                            );
                          },
                          childCount: _favorites!.favoriteSalons.length,
                        ),
                      ),
                    ],
                  ],
                ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final String name;
  final String address;
  final double? rating;
  final String imagePath;
  final String? experience;
  final VoidCallback onRemove;

  const FavoriteCard({
    super.key,
    required this.name,
    required this.address,
    this.rating,
    required this.imagePath,
    required this.onRemove,
    this.experience,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
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
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
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
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  experience == null
                      ? RatingDisplay(rating: rating!)
                      : Text(
                          experience!,
                          style: theme.textTheme.bodySmall,
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
