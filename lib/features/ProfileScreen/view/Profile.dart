import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/controllers/Auth_contoroller.dart';
import 'package:hairs_and_you/router/router.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  double _userRating = 4.5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture (Placeholder for Now)
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(
                          'assets/images/profile_placeholder.png'), // Replace with actual asset
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // User Name
                  Text(
                    user?.displayName ?? "User Name", // Display name if available
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // User Email
                  Text(
                    user?.email ?? "user@example.com", // Display email if available
                    style: TextStyle(
                      fontSize: 18,
                      color: theme.hintColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // User Rating
                  _buildRatingDisplay(theme),
                  const SizedBox(height: 30),
                  // Logout Button
                  ElevatedButton(
                    onPressed: () async {
                      await AuthController.signOut();
                      // ignore: use_build_context_synchronously
                      context.router.replaceAll([const LoginRoute()]);
                    },
                    child: const Text("Выйти"),
                  ),
                  // Add more profile details or options below here
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingDisplay(ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Рейтинг:",
          style: TextStyle(fontSize: 18, color: theme.hintColor),
        ),
        const SizedBox(width: 8),
        Text(
          _userRating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        const SizedBox(width: 4),
        Icon(Icons.star, color: Colors.amber[400], size: 30),
      ],
    );
  }

}