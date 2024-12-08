import 'package:flutter/material.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/profiletextfield.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 254, 247, 255), 
      appBar: const MyAppBar(
        isBackBtnRequired: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      // Profile Avatar
                      const CircleAvatar(
                        radius: 70,
                        backgroundColor: Color.fromARGB(255, 232, 232, 232),
                        child: Icon(Icons.person, size: 100, color: Colors.white),
                      ),
                      // Pen Icon inside a small circle in the bottom-right corner
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            // Add functionality for editing the profile here
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color.fromARGB(255, 246, 246, 246),
                            child: const Icon(
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
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Sandip Magar",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Username field
            ProfileTextField(
              controller: _fullNameController,
              hintText: "Username",
              obsecureText: false,
              prefixIcon: const Icon(Icons.person),
            ),
            const SizedBox(
              height: 20,
            ),
            // Phone Number field
            ProfileTextField(
              controller: _phoneNumberController,
              hintText: "Phone Number",
              obsecureText: false,
              prefixIcon: const Icon(Icons.phone),
            ),
            const SizedBox(
              height: 20,
            ),
            // Email field
            ProfileTextField(
              controller: _emailController,
              hintText: "Email",
              obsecureText: false,
              prefixIcon: const Icon(Icons.email),
            ),
            const SizedBox(
              height: 20,
            ),
            // Password field
            ProfileTextField(
              controller: _passwordController,
              hintText: "Password",
              obsecureText: true,
              prefixIcon: const Icon(Icons.lock),
            ),
            const SizedBox(
              height: 40,
            ),
            // Update button
            MyButton(
              onPressed: () {
                // Handle update logic
              },
              buttontext: "Update",
            ),
          ],
        ),
      ),
    );
  }
}
