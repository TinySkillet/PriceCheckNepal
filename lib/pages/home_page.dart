import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final StatefulNavigationShell shell;

  const HomePage({
    super.key,
    required this.shell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: BottomNavigationBar(
        onTap: shell.goBranch,
        currentIndex: shell.currentIndex,
        selectedItemColor: Theme.of(context).primaryColorDark,
        useLegacyColorScheme: false,
        enableFeedback: false,
        selectedFontSize: 12,
        // onTap:,
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
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
