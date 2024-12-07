import 'package:flutter/material.dart';
import 'package:price_check_np/pages/laptop_specs_page.dart';

class ViewLaptopSpecsButton extends StatelessWidget {
  final Map<String, dynamic> laptop;

  const ViewLaptopSpecsButton({
    super.key,
    required this.laptop,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(
            Theme.of(context).primaryColorLight,
          ),
          padding:
              const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
          side: WidgetStatePropertyAll<BorderSide>(
            BorderSide(
              color: Theme.of(context).primaryColorDark,
              width: 1.0,
            ),
          ),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LaptopSpecsPage(laptop: laptop)));
        },
        child: Text(
          "View Full Specs and Compare Prices",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontFamily: "Noto Sans",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
