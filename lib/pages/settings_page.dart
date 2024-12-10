import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:price_check_np/auth/auth_service.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/snackbar.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _userName = '';
  String _userEmail = '';
  bool _isLoading = true;
  bool _isDonationOptionsVisible = false;

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
          _userName =
              userData.data()?['fullName'] ?? user.displayName ?? 'User';
          _userEmail = user.email ?? '';
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

  void logout(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signOut();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          MySnackbar(message: "Logged out successfully!"),
        );
        context.go('/login');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        MySnackbar(message: "Logout failed: ${e.toString()}"),
      );
    }
  }

  Widget _buildDonationTile() {
    return Column(
      children: [
        ListTile(
          title: const Text(
            "Donate Us!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Noto Sans",
              color: Colors.green,
              fontSize: 18,
            ),
          ),
          subtitle: const Text(
            "Leave us a tip to help us with hosting fees!",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onTap: () {
            setState(() {
              _isDonationOptionsVisible = !_isDonationOptionsVisible;
            });
          },
        ),
        if (_isDonationOptionsVisible)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                ListTile(
                  title: const Text(
                    "Esewa",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    // esewa payment logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      MySnackbar(
                          message: "Esewa donation feature coming soon!"),
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    "Khalti",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    // khalti payment logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      MySnackbar(
                          message: "Khalti donation feature coming soon!"),
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        isBackBtnRequired: false,
        title: "Settings",
        centerTitle: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: [
                  const SizedBox(height: 50),
                  // Profile Section
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          child:
                              Icon(Icons.person, size: 40, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _userEmail,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(height: 30),
                  // View Profile Option
                  ListTile(
                    title: const Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Noto Sans",
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text(
                      "View and Edit Profile",
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      context.push("/profile");
                    },
                  ),
                  const Divider(
                    indent: 15,
                    endIndent: 15,
                  ),
                  // View Terms of Service Option
                  ListTile(
                    title: const Text(
                      "Terms of Service",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Noto Sans",
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text(
                      "View terms of service",
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      // Navigation Logic
                    },
                  ),
                  const Divider(
                    indent: 15,
                    endIndent: 15,
                  ),
                  // Help & Support Option
                  ListTile(
                    title: const Text(
                      "Help & Support",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Noto Sans",
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text(
                      "For assistance,\ncontact us at support@pricechecknepal.com",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onTap: () {
                      // Contact logic
                    },
                  ),
                  const Divider(
                    indent: 15,
                    endIndent: 15,
                  ),
                  _buildDonationTile(),
                  const Divider(
                    indent: 15,
                    endIndent: 15,
                  ),
                  ListTile(
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text(
                      "Logout from this device",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor:
                                Theme.of(context).primaryColorLight,
                            title: const Text(
                              "Are you sure?",
                            ),
                            content: Text(
                              "Are you sure you want to log out?",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 16,
                              ),
                            ),
                            actions: [
                              TextButton(
                                style: ButtonStyle(
                                    textStyle:
                                        const WidgetStatePropertyAll(TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                                    foregroundColor: WidgetStatePropertyAll(
                                        Theme.of(context).primaryColorDark),
                                    backgroundColor: WidgetStatePropertyAll(
                                        Theme.of(context).primaryColorLight)),
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                    textStyle:
                                        const WidgetStatePropertyAll(TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                                    foregroundColor: WidgetStatePropertyAll(
                                        Theme.of(context).primaryColorDark),
                                    backgroundColor: WidgetStatePropertyAll(
                                        Theme.of(context).primaryColorLight)),
                                onPressed: () {
                                  logout(context);
                                },
                                child: const Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
