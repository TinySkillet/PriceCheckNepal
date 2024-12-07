import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:price_check_np/pages/laptop_specs_page.dart';

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LaptopSpecsPage(laptop: laptop)));
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
            // Placeholder for the laptop image (use a valid image URL instead)
            Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                CachedNetworkImage(
                  height: 120,
                  width: 300,
                  imageUrl: laptop["image_url"],
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
