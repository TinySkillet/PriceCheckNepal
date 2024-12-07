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
      width: 210,
      decoration: BoxDecoration(
        color: const Color(0xff92A3FD).withOpacity(.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Placeholder for the laptop image (use a valid image URL instead)
          Column(
            children: [
              const Padding(padding: EdgeInsets.all(30)),
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
    );
  }
}
