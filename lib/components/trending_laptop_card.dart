import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrendingLaptopCard extends StatelessWidget {
  final Map<String, dynamic> laptop;

  const TrendingLaptopCard({
    super.key,
    required this.laptop,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/laptop-specs", extra: laptop);
      },
      child: Container(
        width: double.infinity,
        height: 130,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Row(
          children: [
            // Laptop Image Section
            CachedNetworkImage(
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
            const SizedBox(width: 20),

            // Laptop Details Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Laptop Name
                Text(
                  laptop["name"].length > 16
                      ? "${laptop["name"].substring(0, 16)}..."
                      : laptop["name"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Noto Sans",
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 16,
                  ),
                ),

                // Laptop Specs (RAM & Storage)
                Flexible(
                  child: Text(
                    "RAM: ${laptop["ram"].split(" ")[0]} | STORAGE: ${laptop["storage"].split(" ")[0]}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff7B6F72),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Noto Sans",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
