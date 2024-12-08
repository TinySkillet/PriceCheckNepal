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
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                CachedNetworkImage(
                  height: 120,
                  width: 300,
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  laptop["name"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
