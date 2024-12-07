import 'package:flutter/material.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/popularLaptopCard.dart';
import 'package:price_check_np/components/search_field.dart';
import 'package:price_check_np/components/snackbar.dart';
import 'package:price_check_np/firestore/middleware.dart';
import 'package:price_check_np/pages/login_page.dart';
import 'package:price_check_np/utils/utils.dart';

class HomeContent extends StatelessWidget {
  HomeContent({super.key});

  final FirestoreMiddleware middleware = FirestoreMiddleware();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchField(
              hintText: "Search laptops",
              requiresFilter: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                textAlign: TextAlign.left,
                'Popular Laptops',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 230,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: middleware.getPopularLaptops(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    Utils.showErrorDialog(context, "Error", "!");
                  }

                  final laptops = snapshot.data!;

                  return ListView.separated(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final laptop = laptops[index];
                      return PopularLaptopCard(laptop: laptop);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 25,
                    ),
                  );
                },
              ),
            ),
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
        ),
      ),
    );
  }
}
