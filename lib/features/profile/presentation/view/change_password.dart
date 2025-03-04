import 'dart:convert';

import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isObscureCurrent = true;
  bool _isObscureNew = true;
  bool _isObscureConfirm = true;

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late TokenSharedPrefs tokenSharedPrefs;
  String userId = "";

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenSharedPrefs = TokenSharedPrefs(prefs);

    final userIdResult = await tokenSharedPrefs.getUserId();
    userIdResult.fold(
      (failure) => print("❌ Error fetching user ID: ${failure.message}"),
      (id) {
        setState(() {
          userId = id;
        });
      },
    );
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    // Prepare API request body
    final requestBody = {
      "currentPassword": _currentPasswordController.text,
      "newPassword": _newPasswordController.text
    };

    try {
      final response = await http.put(
        Uri.parse("http://10.0.2.2:3000/api/users/change-password/$userId"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestBody),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Password changed successfully!")),
        );
        Navigator.pop(context); // Close the page after success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ ${responseData['message']}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Failed to change password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Current Password
              TextFormField(
                controller: _currentPasswordController,
                obscureText: _isObscureCurrent,
                decoration: InputDecoration(
                  labelText: "Current Password",
                  suffixIcon: IconButton(
                    icon: Icon(_isObscureCurrent
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () =>
                        setState(() => _isObscureCurrent = !_isObscureCurrent),
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty
                    ? "Please enter your current password"
                    : null,
              ),
              const SizedBox(height: 15),

              // New Password
              TextFormField(
                controller: _newPasswordController,
                obscureText: _isObscureNew,
                decoration: InputDecoration(
                  labelText: "New Password",
                  suffixIcon: IconButton(
                    icon: Icon(_isObscureNew
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () =>
                        setState(() => _isObscureNew = !_isObscureNew),
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Please enter a new password";
                  if (value.length < 6)
                    return "Password must be at least 6 characters";
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Confirm New Password
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _isObscureConfirm,
                decoration: InputDecoration(
                  labelText: "Confirm New Password",
                  suffixIcon: IconButton(
                    icon: Icon(_isObscureConfirm
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () =>
                        setState(() => _isObscureConfirm = !_isObscureConfirm),
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Please confirm your new password";
                  if (value != _newPasswordController.text)
                    return "Passwords do not match";
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: _changePassword,
                  child: const Text("Save New Password"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
