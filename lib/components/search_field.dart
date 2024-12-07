import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  final bool requiresFilter;
  const SearchField({
    super.key,
    required this.hintText,
    required this.requiresFilter,
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
            suffixIcon: SizedBox(
              width: 80,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Offstage(
                      offstage: !requiresFilter,
                      child: VerticalDivider(
                        color: Theme.of(context).primaryColorDark,
                        indent: 10,
                        endIndent: 10,
                        thickness: .1,
                      ),
                    ),
                    Offstage(
                      offstage: !requiresFilter,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset('assets/images/Filter.svg'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
