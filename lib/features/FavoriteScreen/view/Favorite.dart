import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/entities/favorites.dart';
import 'package:hairs_and_you/api/domain/usecases/get_favorites.dart';

import '../../../controllers/Auth_contoroller.dart';
import '../widgets/favoriteCardWidget.dart';

@RoutePage()
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GetFavorites _getFavorites = GetIt.I<GetFavorites>();
  bool _isFavoritesLoading = false;
  String? _favoritesError;
  Favorites? _favorites;

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  void _onSalonOfferTapped(BuildContext context, String id) {
    context.router.pushNamed("/establishment/$id");
  }

  void _onMasterOfferTapped(BuildContext context, String id) {}

  Future<void> _fetchFavorites() async {
    setState(() {
      _isFavoritesLoading = true;
      _favoritesError = null;
    });
    final result = await _getFavorites(userID: AuthController.userID);
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
                    "Нет избранных заведений и мастеров",
                    style: theme.textTheme.bodyMedium,
                  ),
                )
              : CustomScrollView(
                  slivers: [
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
                                onClick: () => _onSalonOfferTapped(
                                    context, favorite.salonId),
                                address:
                                    "${favorite.cityName}, ${favorite.streetAddress}",
                                rating: favorite.rating,
                                imagePath: "assets/images/salon.jpg",
                                type: "salon",
                                id: favorite.salonId,
                              ),
                            );
                          },
                          childCount: _favorites!.favoriteSalons.length,
                        ),
                      ),
                    ],
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
                                onClick: () => _onMasterOfferTapped(
                                    context, favorite.masterID),
                                name: favorite.name,
                                address: favorite.description,
                                experience: favorite.experience,
                                imagePath: "assets/images/master1.jpg",
                                type: "master",
                                id: favorite.masterID,
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
                  ],
                ),
    );
  }
}
