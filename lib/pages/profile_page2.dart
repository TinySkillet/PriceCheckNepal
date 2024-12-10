import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/button2.dart';
import 'package:price_check_np/components/profile_text_field.dart';
import 'package:price_check_np/components/snackbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool isEnabled = false;
  bool _isLoading = true;

  // Store original values to reset on cancel
  String _originalFullName = '';
  String _originalPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();

        setState(() {
          // Populate text controllers with existing data
          _emailController.text = user.email ?? '';
          _fullNameController.text = userData.data()?['fullName'] ?? '';
          _phoneNumberController.text = userData.data()?['phoneNumber'] ?? '';

          // Store original values for potential reset
          _originalFullName = _fullNameController.text;
          _originalPhoneNumber = _phoneNumberController.text;

          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        MySnackbar(message: "Error fetching user data: ${e.toString()}"),
      );
    }
  }

  void toggleEditMode() {
    setState(() {
      if (isEnabled) {
        _fullNameController.text = _originalFullName;
        _phoneNumberController.text = _originalPhoneNumber;
      }
      isEnabled = !isEnabled;
    });
  }

  void updateProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({
          'fullName': _fullNameController.text.trim(),
          'phoneNumber': _phoneNumberController.text.trim(),
        });

        // Update original values
        setState(() {
          _originalFullName = _fullNameController.text.trim();
          _originalPhoneNumber = _phoneNumberController.text.trim();
          isEnabled = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          MySnackbar(message: "Profile updated successfully!"),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        MySnackbar(message: "Error updating profile: ${e.toString()}"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const MyAppBar(
        title: "Profile",
        isBackBtnRequired: true,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 70,
                              backgroundColor:
                                  Color.fromARGB(255, 232, 232, 232),
                              child: Icon(Icons.person,
                                  size: 100, color: Colors.white),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  // Future profile picture update functionality
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Color.fromARGB(255, 246, 246, 246),
                                  child: Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            _fullNameController.text.isNotEmpty
                                ? _fullNameController.text
                                : "Guest",
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Full Name field
                  ProfileTextField(
                    isEnabled: isEnabled,
                    controller: _fullNameController,
                    hintText: "Full Name",
                    obsecureText: false,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  const SizedBox(height: 20),
                  // Phone Number field
                  ProfileTextField(
                    isEnabled: isEnabled,
                    controller: _phoneNumberController,
                    hintText: "Phone Number",
                    obsecureText: false,
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  const SizedBox(height: 20),
                  // Email field (read-only)
                  ProfileTextField(
                    isEnabled: false,
                    controller: _emailController,
                    hintText: "Email",
                    obsecureText: false,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  const SizedBox(height: 40),
                  LightButton(
                    isEnabled: isEnabled,
                    onPressed: toggleEditMode,
                    buttontext: isEnabled ? "Cancel" : "Edit",
                  ),
                  const SizedBox(height: 15),
                  // Update button (only visible when in edit mode)
                  if (isEnabled)
                    LightButton(
                      isEnabled: true,
                      onPressed: updateProfile,
                      buttontext: "Update",
                    ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
