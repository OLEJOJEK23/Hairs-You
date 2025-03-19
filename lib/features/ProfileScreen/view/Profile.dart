import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/features/ProfileScreen/widgets/ProfileMenuWidget.dart';
import '../../../controllers/Auth_contoroller.dart';
import '../../../router/router.dart';

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
          child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture (Placeholder for Now)
                  Stack(
                    children:[
                      Stack(
                        children: [
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
                            radius: 90,
                            backgroundImage: AssetImage(
                                'assets/images/google_logo.png'
                            ),
                          ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration:
                              BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.grey
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    
                                  }, 
                                  icon: Icon(
                                    Icons.photo_camera,
                                    color: theme.primaryColor,
                                  )
                              )
                            ),
                          ),
                        ],
                      ),
                    ]
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
                  // User Email
                  Text(
                    user?.email ?? "user@example.com", // Display email if available
                    style: TextStyle(
                      fontSize: 18,
                      color: theme.hintColor,
                    ),
                  ),
                  // User Rating
                  _buildRatingDisplay(theme),
                  const SizedBox(height: 20),
                  // Edit Profile Button
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        context.router.pushNamed("/changeProfile");
                      },
                      child: const Text(
                          "Редактировать профиль",
                          style: TextStyle(color: Colors.black)
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProfileMenuWidget(
                      title: "Избранное",
                      icon: Icons.favorite,
                      onPress: () {
                        context.router.pushNamed("/favorite");
                      }
                  ),
                  ProfileMenuWidget(
                      title: "История генераций",
                      icon: Icons.history,
                      onPress: () {
                        context.router.pushNamed("/history");
                      }
                  ),
                  ProfileMenuWidget(
                      title: "Настройки",
                      icon: Icons.settings,
                      onPress: () {
                        context.router.pushNamed("/settings");
                      }
                  ),
                  ProfileMenuWidget(
                      title: "Выйти",
                      icon: Icons.logout,
                      textColor: Colors.red,
                      endIcon: false,
                      onPress: () async {
                        await AuthController.signOut();
                        context.router.replaceAll([const LoginRoute()]);;
                      }
                  ),
                ],
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(width: 4),
        Icon(Icons.star, color: Colors.amber[400], size: 20),
      ],
    );
  }

}