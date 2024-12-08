import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:price_check_np/components/appbar.dart';

class LaptopSpecsPage extends StatelessWidget {
  final Map<String, dynamic> laptop;
  const LaptopSpecsPage({
    super.key,
    required this.laptop,
  });

  String getLaptopInfo(Map<String, dynamic> laptop, String key) {
    return laptop.containsKey(key) && laptop[key] != null
        ? "${key.toUpperCase()}: ${laptop[key]}"
        : "${key.toUpperCase()}: N/A";
  }

  // Method to launch URL
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get sources from the laptop map
    final Map<String, dynamic> sources = laptop['sources'] ?? {};

    return Scaffold(
      appBar: const MyAppBar(
        isBackBtnRequired: true,
        centerTitle: true,
        title: "Specifications",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      height: 300,
                      width: 300,
                      imageUrl: laptop["image_url"],
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                laptop["name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Noto Sans",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getLaptopInfo(laptop, "brand")),
                  Text(getLaptopInfo(laptop, "processor")),
                  Text(getLaptopInfo(laptop, "ram")),
                  Text(getLaptopInfo(laptop, "storage")),
                  Text(getLaptopInfo(laptop, "display")),
                  Text(getLaptopInfo(laptop, "graphics")),
                  Text(getLaptopInfo(laptop, "camera")),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Sources",
                style: TextStyle(
                  fontFamily: "Noto Sans",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 20,
                ),
              ),
            ),
            // Sources List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sources.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () => _launchUrl(entry.value['url']),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            'NPR ${entry.value['price'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
