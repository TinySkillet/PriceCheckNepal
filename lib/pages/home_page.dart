import 'package:flutter/material.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/snackbar.dart';
import 'package:price_check_np/pages/login_page.dart';
import 'package:price_check_np/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeContent(), // Home screen content
    ProfilePage(), // Profile page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        isBackBtnRequired: false,
        title: "Home Page",
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColorDark,
        useLegacyColorScheme: false,
        enableFeedback: false,
        selectedFontSize: 12,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Theme.of(context).primaryColorLight,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColorDark,
            icon: const Icon(
              Icons.home,
              weight: .2,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColorDark,
            icon: const Icon(
              Icons.person,
              weight: .2,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MyButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              MySnackbar(message: "Logged out successfully!"),
            );
          },
          buttontext: "Logout",
        ),
      ],
    );
  }
}
