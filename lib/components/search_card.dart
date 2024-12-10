import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:price_check_np/firestore/middleware.dart';

class SearchCard extends StatelessWidget {
  final Map<String, dynamic> laptop;

  const SearchCard({super.key, required this.laptop});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FirestoreMiddleware middleware = FirestoreMiddleware();
        middleware.storeRecentSearch(laptop['id']);
        context.push('/laptop-specs', extra: laptop);
      },
      child: Card(
        color: Theme.of(context).primaryColorLight,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        elevation: 4,
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            laptop['name'] ?? 'Unknown Laptop',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Noto Sans",
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Brand: ${laptop['brand'] ?? 'Unknown'}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'RAM: ${laptop['ram'] ?? 'Unknown'}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Storage: ${laptop['storage'] ?? 'Unknown'}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: CachedNetworkImage(
            height: 100,
            width: 100,
            imageUrl: laptop["image_url"] ??
                "https://img.freepik.com/free-vector/sky-scene-laptop-desktop_1308-49390.jpg?t=st=1733573684~exp=1733577284~hmac=19ca671516c0d1b5df221420338fa397768fb0f226383401f3670c365fd6325c&w=1800",
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => Image.asset(
              "assets/images/laptop_placeholder.png",
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
