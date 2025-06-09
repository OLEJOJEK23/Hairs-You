import 'package:flutter/material.dart';
import 'package:hairs_and_you/controllers/favorites_controller.dart';

import '../controllers/Auth_contoroller.dart';

class FavoriteButton extends StatefulWidget {
  final String type; // 'master' или 'salon'
  final String id; // masterID или salonId
  final bool initialFavorite; // Начальное состояние

  const FavoriteButton({
    super.key,
    required this.type,
    required this.id,
    this.initialFavorite = true,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool isFavorite;
  static String userID = AuthController.userID;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavorite;
  }

  void _toggleFavorite() {
    if (widget.type == "master") {
      if (isFavorite == true) {
        FavoritesController().removeFavoriteMaster(userID, widget.id);
      } else {
        FavoritesController().addFavoriteMaster(userID, widget.id);
      }
    } else {
      if (isFavorite == true) {
        FavoritesController().removeFavoriteSalon(userID, widget.id);
      } else {
        FavoritesController().addFavoriteSalon(userID, widget.id);
      }
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color:
            isFavorite ? Colors.redAccent : theme.colorScheme.onSurfaceVariant,
      ),
      onPressed: _toggleFavorite,
    );
  }
}
