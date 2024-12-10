import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  final bool autofocus;
  final Function()? onTap;
  final Function()? onComplete;
  final TextEditingController? controller;

  const SearchField({
    super.key,
    required this.hintText,
    required this.autofocus,
    this.controller,
    this.onTap,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Theme.of(context).primaryColorDark.withOpacity(.11),
          blurRadius: 40,
          spreadRadius: 0.0,
        )
      ]),
      child: TextField(
        autofocus: autofocus,
        onEditingComplete: onComplete,
        controller: controller,
        onTap: onTap ?? () {},
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontFamily: "Noto Sans",
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset('assets/images/Search.svg'),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
