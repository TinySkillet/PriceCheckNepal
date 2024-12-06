import 'package:flutter/material.dart';
import 'package:price_check_np/pages/profile_page.dart';

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
        backgroundColor: Colors.white,
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
                  MaterialPageRoute(builder: (context) => ProfilePage()),
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
                // Add navigation Logic
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
              trailing: Text(
                "support@pricechecknepal.com",
                style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              onTap: () {
                // Add contact logic
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
                // Add logout logic
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
