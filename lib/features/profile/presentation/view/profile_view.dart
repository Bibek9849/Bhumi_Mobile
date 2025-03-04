import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/core/theme/theme_cubit.dart';
import 'package:bhumi_mobile/features/profile/presentation/view/change_password.dart';
import 'package:bhumi_mobile/features/profile/presentation/view/edit_profile.dart';
import 'package:bhumi_mobile/features/profile/presentation/view/help_center.dart';
import 'package:bhumi_mobile/features/profile/presentation/view_model/bloc/student_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TokenSharedPrefs tokenSharedPrefs;
  String fullName = "Loading...";
  String contactNumber = "Loading...";
  String profileImage = ""; // ✅ Added missing profileImage variable

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenSharedPrefs = TokenSharedPrefs(prefs);

    // ✅ Fetch Full Name
    final nameResult = await tokenSharedPrefs.getUserFullName();
    nameResult.fold(
      (failure) => print("❌ Error fetching full name: ${failure.message}"),
      (name) {
        setState(() {
          fullName = name.isNotEmpty ? name : "User not found";
        });
      },
    );

    // ✅ Fetch Contact Number
    final contactResult = await tokenSharedPrefs.getUserContact();
    contactResult.fold(
      (failure) => print("❌ Error fetching contact: ${failure.message}"),
      (contact) {
        setState(() {
          contactNumber = contact.isNotEmpty ? contact : "Not Provided";
        });
      },
    );

    // ✅ Fetch Profile Image
    final imageResult = await tokenSharedPrefs.getUserImage();
    imageResult.fold(
      (failure) => print("❌ Error fetching profile image: ${failure.message}"),
      (image) {
        setState(() {
          profileImage = image; // ✅ Set the correct image URL
        });
      },
    );
  }

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
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          NetworkImage(profileImage), // ✅ Use NetworkImage
                      onBackgroundImageError: (exception, stackTrace) {
                        setState(() {
                          profileImage =
                              "https://i.pravatar.cc/150?img=3"; // ✅ Default fallback
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName, // ✅ Show fetched full name
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          contactNumber, // ✅ Show fetched contact number
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    final state = context.read<StudentProfileBloc>().state;

                    if (state is StudentProfileLoaded ||
                        state is StudentProfileUpdated) {
                      final student = state is StudentProfileLoaded
                          ? state.student
                          : (state as StudentProfileUpdated).student;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditStudentProfileView(student: student),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Error: No User data available!")),
                      );
                    }
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
                              builder: (context) =>
                                  const ChangePasswordScreen()),
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
                      context.read<StudentProfileBloc>().logout(context);
                    },
                  ),
                  const SectionTitle(title: "App Setting"),
                  const SettingsItem(icon: Icons.language, title: "Language"),
                  const SettingsItem(icon: Icons.security, title: "Security"),
                  const SectionTitle(title: "Support"),
                  SettingsItem(
                      icon: Icons.help_outline,
                      title: "Help Center",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpCenter()),
                        );
                      }),
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
      onTap: onPressed,
    );
  }
}

// Dark Mode Toggle Widget
class DarkModeToggle extends StatelessWidget {
  const DarkModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const Text(
            "Dark Mode",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: Switch(
            value: isDarkMode,
            onChanged: (bool value) {
              context.read<ThemeCubit>().toggleTheme(value);
            },
          ),
        );
      },
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
