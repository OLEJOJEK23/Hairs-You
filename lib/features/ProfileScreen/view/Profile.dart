import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/entities/user.dart';
import 'package:hairs_and_you/api/domain/usecases/get_users.dart';
import 'package:hairs_and_you/features/ProfileScreen/widgets/ProfileMenuWidget.dart';
import 'package:hairs_and_you/widgets/RatingDisplay.dart';
import 'package:image_picker/image_picker.dart';

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
  final GetUsers _getUsers = GetIt.I<GetUsers>();
  late Users _user;
  File? _usersImage;
  final _picker = ImagePicker();
  bool _isUsersLoading = false;
  String? _usersError;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isUsersLoading = true;
      _usersError = null;
    });
    final result = await _getUsers(
      userID: _auth.currentUser!.uid,
    );
    result.fold(
      (failure) => setState(() {
        _usersError = failure.message;
        _isUsersLoading = true;
      }),
      (users) => setState(() {
        _user = users[0];
        _isUsersLoading = false;
      }),
    );
    if (_usersError != null) {
      print(_usersError);
    }
  }

  void pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _usersImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _isUsersLoading
        ? Center(
            child: CircularProgressIndicator(
              color: theme.primaryColor,
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withValues(alpha: 0.2),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 90,
                                  backgroundImage: _usersImage != null
                                      ? FileImage(_usersImage!)
                                      : const AssetImage(
                                          "assets/images/google_logo.png",
                                        ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: theme.focusColor,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      pickImage();
                                    },
                                    icon: Icon(
                                      Icons.photo_camera,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // User Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _user.displayName,
                            // Display name if available
                            style: theme.textTheme.titleLarge,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.change_circle),
                          )
                        ],
                      ),
                      // User Email
                      Text(
                        _user.email ?? _user.phone!,
                        // Display email if available
                        style: theme.textTheme.bodyMedium,
                      ),
                      // User Rating
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Рейтинг: "),
                            RatingDisplay(rating: _user.rating),
                          ],
                        ),
                      ),
                      // Edit Profile Button
                      const Divider(),
                      const SizedBox(height: 10),
                      ProfileMenuWidget(
                        title: "Избранное",
                        icon: Icons.favorite,
                        onPress: () {
                          context.router.pushNamed("/favorite");
                        },
                      ),
                      ProfileMenuWidget(
                        title: "История посещений",
                        icon: Icons.history,
                        onPress: () {
                          context.router.pushNamed("/history");
                        },
                      ),
                      ProfileMenuWidget(
                        title: "Настройки",
                        icon: Icons.settings,
                        onPress: () {
                          context.router.pushNamed("/settings");
                        },
                      ),
                      ProfileMenuWidget(
                        title: "Выйти",
                        icon: Icons.logout,
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () async {
                          await GetIt.I<AuthController>().signOut();
                          if (!context.mounted) return;
                          context.router.replaceAll([const LoginRoute()]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
