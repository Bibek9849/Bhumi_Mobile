import 'dart:async';
import 'dart:math' as math;

import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/core/theme/theme_cubit.dart';
import 'package:bhumi_mobile/features/profile/presentation/view/change_password.dart';
import 'package:bhumi_mobile/features/profile/presentation/view/edit_profile.dart';
import 'package:bhumi_mobile/features/profile/presentation/view/help_center.dart';
import 'package:bhumi_mobile/features/profile/presentation/view_model/bloc/student_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';
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
  String profileImage = "";

  // Shake detection variables
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  int _shakeCount = 0;
  DateTime? _lastShakeTime;

  // Adjust these thresholds as needed
  final double shakeThreshold = 15.0; // acceleration threshold
  final Duration shakeResetTime = const Duration(seconds: 1);
  final Duration minShakeInterval = const Duration(milliseconds: 500);
  final int requiredShakes = 3;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _startShakeDetection();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenSharedPrefs = TokenSharedPrefs(prefs);

    final nameResult = await tokenSharedPrefs.getUserFullName();
    nameResult.fold(
      (failure) => debugPrint("❌ Error fetching full name: ${failure.message}"),
      (name) {
        setState(() {
          fullName = name.isNotEmpty ? name : "User not found";
        });
      },
    );

    final contactResult = await tokenSharedPrefs.getUserContact();
    contactResult.fold(
      (failure) => debugPrint("❌ Error fetching contact: ${failure.message}"),
      (contact) {
        setState(() {
          contactNumber = contact.isNotEmpty ? contact : "Not Provided";
        });
      },
    );

    final imageResult = await tokenSharedPrefs.getUserImage();
    imageResult.fold(
      (failure) =>
          debugPrint("❌ Error fetching profile image: ${failure.message}"),
      (image) {
        setState(() {
          profileImage = image;
        });
      },
    );
  }

  void _startShakeDetection() {
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      // Calculate the magnitude of the acceleration vector
      double acceleration =
          math.sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      // When the phone is stationary, the magnitude is ~9.8 due to gravity.
      // A significant deviation (e.g. > shakeThreshold) indicates a shake.
      if (acceleration > shakeThreshold) {
        DateTime now = DateTime.now();
        // Reset shake count if too much time has passed since the last shake.
        if (_lastShakeTime == null ||
            now.difference(_lastShakeTime!) > shakeResetTime) {
          _shakeCount = 0;
        }
        // Ensure a minimum interval between shake events
        if (_lastShakeTime == null ||
            now.difference(_lastShakeTime!) > minShakeInterval) {
          _shakeCount++;
          _lastShakeTime = now;
          debugPrint("Shake detected. Count: $_shakeCount");

          if (_shakeCount >= requiredShakes) {
            debugPrint("Shake threshold reached. Logging out...");
            // Show a logout snackbar message
            showMySnackBar(
              context: context,
              message: 'Logging out...',
              color: Colors.red,
            );
            // Trigger logout action
            context.read<StudentProfileBloc>().logout(context);
            // Reset the counter after logging out
            _shakeCount = 0;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define a maximum width for better layout on tablets.
    const double maxContentWidth = 600;
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // ─────────────────────────────────────────────
                  // Profile Info with Edit Icon
                  // ─────────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor:
                                theme.colorScheme.surfaceContainerHighest,
                            backgroundImage: profileImage.isNotEmpty
                                ? NetworkImage(profileImage)
                                : const AssetImage("assets/images/profile.jpg")
                                    as ImageProvider,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fullName,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                contactNumber,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
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
                              builder: (context) =>
                                  const EditStudentProfileView(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // ─────────────────────────────────────────────
                  // Settings Sections (ListView)
                  // ─────────────────────────────────────────────
                  Expanded(
                    child: ListView(
                      children: [
                        // General Section
                        SectionTitle(title: "General", textColor: textColor),
                        SettingsItem(
                          icon: Icons.event_note,
                          title: "Change Password",
                          textColor: textColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ChangePasswordScreen(),
                              ),
                            );
                          },
                        ),
                        // Account Setting Section
                        SectionTitle(
                            title: "Account Setting", textColor: textColor),
                        const DarkModeToggle(),
                        SettingsItem(
                          icon: Icons.logout,
                          title: "Logout",
                          isLogout: true,
                          textColor: textColor,
                          onPressed: () {
                            showMySnackBar(
                              context: context,
                              message: 'Logging out...',
                              color: Colors.red,
                            );
                            context.read<StudentProfileBloc>().logout(context);
                          },
                        ),
                        // App Setting Section
                        SectionTitle(
                            title: "App Setting", textColor: textColor),
                        SettingsItem(
                          icon: Icons.language,
                          title: "Language",
                          textColor: textColor,
                          onPressed: () {
                            // Handle language settings
                          },
                        ),
                        SettingsItem(
                          icon: Icons.security,
                          title: "Security",
                          textColor: textColor,
                          onPressed: () {
                            // Handle security settings
                          },
                        ),
                        // Support Section
                        SectionTitle(title: "Support", textColor: textColor),
                        SettingsItem(
                          icon: Icons.help_outline,
                          title: "Help Center",
                          textColor: textColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HelpCenter(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Section Title Widget
// ─────────────────────────────────────────────
class SectionTitle extends StatelessWidget {
  final String title;
  final Color textColor;

  const SectionTitle({super.key, required this.title, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor.withOpacity(0.8),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Settings Item Widget
// ─────────────────────────────────────────────
class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLogout;
  final VoidCallback? onPressed;
  final Color textColor;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.isLogout = false,
    this.onPressed,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : textColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isLogout ? Colors.red : textColor,
        ),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onPressed,
    );
  }
}

// ─────────────────────────────────────────────
// Dark Mode Toggle Widget
// ─────────────────────────────────────────────
class DarkModeToggle extends StatelessWidget {
  const DarkModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return ListTile(
          leading: const Icon(Icons.dark_mode),
          title: Text(
            "Dark Mode",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
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

// ─────────────────────────────────────────────
// Snackbar Function
// ─────────────────────────────────────────────
void showMySnackBar({
  required BuildContext context,
  required String message,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    ),
  );
}
