import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopularLaptopCard extends StatelessWidget {
  final Map<String, dynamic> laptop;

  const PopularLaptopCard({
    super.key,
    required this.laptop,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/laptop-specs', extra: laptop);
      },
      child: Container(
        width: 240,
        height: 380,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                // Image Section
                CachedNetworkImage(
                  height: 120,
                  width: 120, // Adjusting width for a better fit
                  imageUrl: laptop["image_url"] ??
                      "https://img.freepik.com/free-vector/sky-scene-laptop-desktop_1308-49390.jpg?t=st=1733573684~exp=1733577284~hmac=19ca671516c0d1b5df221420338fa397768fb0f226383401f3670c365fd6325c&w=1800",
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/laptop_placeholder.png",
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),

                // Laptop Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    laptop["name"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Noto Sans",
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 16,
                    ),
                  ),
                ),

                // Specs Information (RAM & Storage)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "RAM: ${laptop["ram"].split(" ")[0]} | STORAGE: ${laptop["storage"].split(" ")[0]}",
                    style: const TextStyle(
                      color: Color(0xff7B6F72),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Noto Sans",
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Space below text
              ],
            ),
          ],
        ),
      ),
    );
  }
}
