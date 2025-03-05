import 'dart:convert';
import 'dart:io';

import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditStudentProfileView extends StatefulWidget {
  const EditStudentProfileView({super.key});

  @override
  _EditStudentProfileViewState createState() => _EditStudentProfileViewState();
}

class _EditStudentProfileViewState extends State<EditStudentProfileView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  File? _img;
  late TokenSharedPrefs tokenSharedPrefs;
  String userId = "";
  String authToken = "";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenSharedPrefs = TokenSharedPrefs(prefs);

    final nameResult = await tokenSharedPrefs.getUserFullName();
    final contactResult = await tokenSharedPrefs.getUserContact();
    final imageResult = await tokenSharedPrefs.getUserImage();
    final userIdResult = await tokenSharedPrefs.getUserId();
    final tokenResult = await tokenSharedPrefs.getToken();

    nameResult.fold(
      (failure) => print("❌ Error fetching full name: ${failure.message}"),
      (name) => setState(() {
        _nameController.text = name.isNotEmpty ? name : "User not found";
      }),
    );

    contactResult.fold(
      (failure) => print("❌ Error fetching contact: ${failure.message}"),
      (contact) => setState(() {
        _phoneController.text = contact.isNotEmpty ? contact : "Not Provided";
      }),
    );

    imageResult.fold(
      (failure) => print("❌ Error fetching profile image: ${failure.message}"),
      (image) => setState(() {
        _img = image.isNotEmpty ? File(image) : null;
      }),
    );

    userIdResult.fold(
      (failure) => print("❌ Error fetching user ID: ${failure.message}"),
      (id) => setState(() {
        userId = id;
      }),
    );

    tokenResult.fold(
      (failure) => print("❌ Error fetching token: ${failure.message}"),
      (token) => setState(() {
        authToken = token;
      }),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _img = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      String apiUrl = "http://10.0.2.2:3000/api/users/update-profile/$userId";
      var request = http.MultipartRequest("PUT", Uri.parse(apiUrl));

      request.fields["fullName"] = _nameController.text;
      request.fields["email"] = _emailController.text;
      request.fields["contact"] = _phoneController.text;
      request.headers["Authorization"] = "Bearer $authToken";

      if (_img != null) {
        request.files
            .add(await http.MultipartFile.fromPath("image", _img!.path));
      }

      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          var responseData = json.decode(await response.stream.bytesToString());
          print("✅ Profile Updated Successfully: $responseData");

          // ✅ Update SharedPreferences to store the latest data
          await tokenSharedPrefs.saveUserFullName(_nameController.text);
          await tokenSharedPrefs.saveUserContact(_phoneController.text);
          if (_img != null) {
            await tokenSharedPrefs.saveUserImage(_img!.path);
          }

          Navigator.pop(context);
        } else {
          print(
              "❌ Failed to update profile. Status Code: ${response.statusCode}");
        }
      } catch (error) {
        print("❌ Error updating profile: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 90,
                  backgroundColor: theme.dividerColor,
                  backgroundImage: _img != null
                      ? FileImage(_img!) as ImageProvider
                      : const AssetImage('assets/default_profile.png'),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  _pickImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _pickImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueGrey,
                      ),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: "Full Name",
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _emailController,
                    label: "Email",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _phoneController,
                    label: "Phone Number",
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _updateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text("Save Changes", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      required IconData icon,
      TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? "Please enter your $label" : null,
    );
  }
}
