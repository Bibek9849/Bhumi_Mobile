import 'package:bhumi_mobile/features/profile/presentation/view/change_password.dart';
import 'package:bhumi_mobile/features/profile/presentation/view/edit_profile.dart';
import 'package:bhumi_mobile/features/profile/presentation/view_model/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Info with Edit Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150?img=3'), // Placeholder image
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bibek Pandey",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "9849943368",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
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
            const SizedBox(height: 24),

            // Settings Sections
            Expanded(
              child: ListView(
                children: [
                  const SectionTitle(title: "General"),
                  SettingsItem(
                      icon: Icons.event_note,
                      title: "Change Password",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangePassword()),
                        );
                      }),
                  const SectionTitle(title: "Account Setting"),
                  const DarkModeToggle(),
                  SettingsItem(
                    icon: Icons.logout,
                    title: "Logout",
                    isLogout: true,
                    onPressed: () {
                      showMySnackBar(
                        context: context,
                        message: 'Logging out...',
                        color: Colors.red,
                      );
                      context.read<ProfileBloc>().logout(context);
                    },
                  ),
                  const SectionTitle(title: "App Setting"),
                  const SettingsItem(icon: Icons.language, title: "Language"),
                  const SettingsItem(icon: Icons.security, title: "Security"),
                  const SectionTitle(title: "Support"),
                  const SettingsItem(
                      icon: Icons.help_outline, title: "Help Center"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Section Title Widget
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
    );
  }
}

// Settings Item Widget
class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLogout;
  final VoidCallback? onPressed;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.isLogout = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isLogout ? Colors.red : Colors.black,
        ),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onPressed, // Calls function when tapped
    );
  }
}

// Dark Mode Toggle Widget
class DarkModeToggle extends StatefulWidget {
  const DarkModeToggle({super.key});

  @override
  _DarkModeToggleState createState() => _DarkModeToggleState();
}

class _DarkModeToggleState extends State<DarkModeToggle> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.dark_mode),
      title: const Text("Dark Mode",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (bool value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }
}

// Snackbar Function
void showMySnackBar(
    {required BuildContext context,
    required String message,
    required Color color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    ),
  );
}
