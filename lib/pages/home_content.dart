import 'package:flutter/material.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/popular_laptop_card.dart';
import 'package:price_check_np/components/search_field.dart';
import 'package:price_check_np/components/trending_laptop_card.dart';
import 'package:price_check_np/firestore/middleware.dart';
import 'package:price_check_np/utils/utils.dart';
import 'package:go_router/go_router.dart';

class HomeContent extends StatelessWidget {
  HomeContent({
    super.key,
  });

  final FirestoreMiddleware middleware = FirestoreMiddleware();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        isBackBtnRequired: false,
        title: "Home",
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(
              hintText: "Search laptops",
              autofocus: false,
              onTap: () {
                context.push("/search");
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                textAlign: TextAlign.left,
                'Popular Laptops',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 20,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
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
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                textAlign: TextAlign.left,
                'Trending Laptops',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              // height: 230,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: middleware
                    .getPopularLaptops(), // Replace with your method to fetch all laptops
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    Utils.showErrorDialog(
                        context, "Error", "Failed to load laptops.");
                    return const SizedBox();
                  }

                  final laptops = snapshot.data!.skip(5).take(8).toList();

                  return Column(
                    children: laptops.map((laptop) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TrendingLaptopCard(laptop: laptop),
                            const SizedBox(
                              height: 15,
                            ),
                            // ViewLaptopSpecsButton(laptop: laptop),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
