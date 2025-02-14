import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tazkartak_app/core/dependency_injection/di.dart';
import 'package:tazkartak_app/src/presentation/mangers/auth/profile/profile_state.dart';
import 'package:tazkartak_app/src/presentation/mangers/auth/profile/profile_viewmodel.dart';
import 'package:tazkartak_app/src/tazkartak.dart';

import '../../../../core/routes/routes_name.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewmodel profileViewmodel = getIt<ProfileViewmodel>();

  @override
  void initState() {
    super.initState();
    profileViewmodel.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove the default AppBar for a custom gradient header
      body: BlocProvider(
        create: (context) => profileViewmodel,
        child: BlocBuilder<ProfileViewmodel, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Custom Gradient Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepPurple.shade700,
                          Colors.deepPurple.shade300,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: const AssetImage(
                              'assets/images/profile_placeholder.png'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          profileViewmodel.user.name ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          profileViewmodel.user.email ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Profile Options Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _ProfileOption(
                            icon: Icons.edit,
                            title: 'Edit Profile',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen(),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          _ProfileOption(
                            icon: Icons.language,
                            title: 'Language',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LanguageSelectionScreen(),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          _ProfileOption(
                            icon: Icons.info,
                            title: 'About Us',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AboutUsScreen(),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          _ProfileOption(
                            icon: Icons.logout,
                            title: 'Logout',
                            onTap: () {
                              // Show a confirmation dialog before logging out.
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Confirm Logout'),
                                  content: const Text(
                                      'Are you sure you want to logout?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        profileViewmodel.logout();
                                        navKey.currentState!
                                            .pushNamedAndRemoveUntil(
                                          RoutesName.login,
                                          (route) => false,
                                        );
                                      },
                                      child: const Text('Logout'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// A reusable widget for each option in the profile screen.
class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.deepPurple,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}

/// Dummy screen for editing profile information.
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  // Replace with your actual form or UI to edit profile information.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(child: Text('Edit Profile Screen')),
    );
  }
}

/// Dummy screen for language selection.
class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  // Replace with your actual language selection UI.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(child: Text('Language Selection Screen')),
    );
  }
}

/// Dummy screen for About Us information.
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  // Replace with your actual About Us content.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(child: Text('About Us Screen')),
    );
  }
}
