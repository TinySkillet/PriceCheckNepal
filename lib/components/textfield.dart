import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final bool obsecureText; // To control visibility of the eye icon
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obsecureText,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obsecureText; // Initialize with the passed value
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        obscureText: _isObscured,
        style: TextStyle(
          fontFamily: "Noto Sans",
          color: Theme.of(context).primaryColorDark,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          //  show the eye icon if obsecureText is true
          suffixIcon: widget.obsecureText
              ? IconButton(
                  icon: Icon(
                    _isObscured
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_sharp,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured; // Toggle visibility state
                    });
                  },
                )
              : null, // No icon for non-password fields
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).indicatorColor,
            ),
          ),
          fillColor: Theme.of(context).primaryColorLight,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontFamily: "Noto Sans",
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        controller: widget.controller,
      ),
    );
  }
}
