import 'package:flutter/material.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/search_card.dart';
import 'package:price_check_np/firestore/middleware.dart';

class RecentViewsPage extends StatelessWidget {
  RecentViewsPage({super.key});

  final FirestoreMiddleware middleware = FirestoreMiddleware();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        isBackBtnRequired: true,
        title: "Recently Viewed",
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: middleware.getRecentSearches(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No recent searches'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final laptop = snapshot.data![index];
                    return SearchCard(laptop: laptop);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
