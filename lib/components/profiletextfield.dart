import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  final Icon? prefixIcon;

  const ProfileTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
    this.prefixIcon
  }) : super(key: key);

  @override
  _ProfileTextFieldState createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obsecureText;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8; // 80% of screen width

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.hintText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: widget.controller,
            obscureText: _isObscured,
            style: TextStyle(
              color: const Color.fromARGB(255, 61, 61, 61),
            ),
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.obsecureText
                  ? IconButton(
                      icon: Icon(
                        _isObscured
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_sharp,
                        color: const Color.fromARGB(255, 72, 72, 72), // Icon color
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : null, 
              filled: true,
              fillColor: const Color.fromARGB(255, 254, 247, 255),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 54, 53, 53), // Grey border color
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.grey, 
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
