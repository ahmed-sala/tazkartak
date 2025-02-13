import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tazkartak_app/core/dependency_injection/di.dart';
import 'package:tazkartak_app/src/presentation/mangers/auth/profile/profile_state.dart';
import 'package:tazkartak_app/src/presentation/mangers/auth/profile/profile_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewmodel profileViewmodel = getIt<ProfileViewmodel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileViewmodel.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: const Color(0xFF0A2C66),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => profileViewmodel,
        child: SingleChildScrollView(
          child: BlocBuilder<ProfileViewmodel, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProfileErrorState) {
                return Center(child: Text(state.errorMessage));
              }
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0A2C66),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(''),
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
                  // List of profile options.
                  _ProfileOption(
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfileScreen()),
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
                                const LanguageSelectionScreen()),
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
                            builder: (context) => const AboutUsScreen()),
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
                          content:
                              const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // TODO: Implement your logout logic here.
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                ],
              );
            },
          ),
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
        color: Color(0xFF0A2C66),
      ),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
        backgroundColor: Colors.blueAccent,
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
        backgroundColor: Colors.blueAccent,
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
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(child: Text('About Us Screen')),
    );
  }
}
