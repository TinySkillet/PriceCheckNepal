import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackBtnRequired;
  const MyAppBar({
    super.key,
    this.title,
    required this.isBackBtnRequired,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leadingWidth: 100,
      leading: isBackBtnRequired
          ? Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1.0, color: Theme.of(context).indicatorColor),
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                tooltip: "Back",
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Theme.of(context).indicatorColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontFamily: "Noto Sans",
                fontWeight: FontWeight.bold,
              ),
            )
          : null, // showing title only if provided
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
