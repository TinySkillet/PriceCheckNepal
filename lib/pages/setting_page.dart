import 'package:flutter/material.dart';
import 'package:price_check_np/Esewa%20Functions/esewa.dart';
import 'package:price_check_np/pages/esewa_page.dart';
import 'package:price_check_np/pages/profile_page.dart';
import 'package:price_check_np/pages/login_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 254, 247, 255),
        elevation: 0,
        leading: const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            // Profile Section
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Aditya Poudel",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "adityapoudel@gmail.com",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),
            // Profile Option
            ListTile(
              title: const Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("Update and Delete Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            const Divider(),
            // Terms of Service Option
            ListTile(
              title: const Text(
                "Terms of Service",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("View terms of service"),
              onTap: () {
                // Navigation Logic
              },
            ),
            const Divider(),
            // Help & Support Option
            ListTile(
              title: const Text(
                "Help & Support",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("For assistance, contact us at"),
              trailing: const Text(
                "support@pricechecknepal.com",
              ),
              onTap: () {
                // Contact logic
              },
            ),
            const Divider(),

            ListTile(
              title: const Text(
                "Donation",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("Help us by donating us through esewa"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EsewaScreen()),
                );
              },
            ),
            const Divider(),

            // Logout Option
            ListTile(
              title: const Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              subtitle: const Text("Sign out of your account"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to log out?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Profile is active
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
