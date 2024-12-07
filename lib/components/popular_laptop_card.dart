import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PopularLaptopCard extends StatelessWidget {
  final Map<String, dynamic> laptop;

  const PopularLaptopCard({
    super.key,
    required this.laptop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Placeholder for the laptop image (use a valid image URL instead)
          Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 20)),
              CachedNetworkImage(
                height: 150,
                width: 300,
                imageUrl: laptop["image_url"] ??
                    "https://img.freepik.com/free-vector/sky-scene-laptop-desktop_1308-49390.jpg?t=st=1733573684~exp=1733577284~hmac=19ca671516c0d1b5df221420338fa397768fb0f226383401f3670c365fd6325c&w=1800",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/laptop_placeholder.jpg", // Replace with your local placeholder image
                  height: 150,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
              Text(
                "RAM: ${laptop["ram"].split(" ")[0]} | STORAGE: ${laptop["storage"].split(" ")[0]}",
                style: const TextStyle(
                  color: Color(0xff7B6F72),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Noto Sans",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
