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

  // Helper method to launch a URL
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 20),
            _LaptopImage(imageUrl: laptop["image_url"]),
            const SizedBox(height: 20),
            _LaptopName(name: laptop["name"]),
            const SizedBox(height: 20),
            _SpecificationsList(laptop: laptop),
            const SizedBox(height: 25),
            _SourcesList(
              sources: laptop['sources'] ?? {},
              onTap: _launchUrl,
            ),
          ],
        ),
      ),
    );
  }
}

// laptop image
class _LaptopImage extends StatelessWidget {
  final String imageUrl;
  const _LaptopImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        height: 300,
        width: 300,
        imageUrl: imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

// laptop name
class _LaptopName extends StatelessWidget {
  final String name;
  const _LaptopName({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Text(
        name,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: "Noto Sans",
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColorDark,
          fontSize: 20,
        ),
      ),
    );
  }
}

// specifications list
class _SpecificationsList extends StatelessWidget {
  final Map<String, dynamic> laptop;
  const _SpecificationsList({required this.laptop});

  Widget _buildSpecItem(BuildContext context, String label, String? value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              textAlign: TextAlign.end,
              value ?? 'N/A',
              style: TextStyle(
                color: Theme.of(context).primaryColorDark.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSpecItem(context, "Brand", laptop["brand"]),
          _buildSpecItem(context, "Processor", laptop["processor"]),
          _buildSpecItem(context, "RAM", laptop["ram"]),
          _buildSpecItem(context, "Storage", laptop["storage"]),
          _buildSpecItem(context, "Display", laptop["display"]),
          _buildSpecItem(context, "Graphics", laptop["graphics"]),
          _buildSpecItem(context, "Camera", laptop["camera"]),
        ],
      ),
    );
  }
}

// sources list
class _SourcesList extends StatelessWidget {
  final Map<String, dynamic> sources;
  final Function(String) onTap;
  const _SourcesList({required this.sources, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sources",
            style: TextStyle(
              fontFamily: "Noto Sans",
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColorDark,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          ...sources.entries.map((entry) {
            return GestureDetector(
              onTap: () => onTap(entry.value['url']),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Noto Sans",
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'NPR ${entry.value['price'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Noto Sans",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
