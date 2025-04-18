import 'package:flutter/material.dart';

import '../../tools/design.dart';

class PassTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final Icon prefixIcon;

  const PassTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.prefixIcon,
    required this.label,
  });

  @override
  State<PassTextField> createState() => _PassTextFieldState();
}

class _PassTextFieldState extends State<PassTextField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: !_passwordVisible,
        style: const TextStyle(color: color4),
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          fillColor: color6,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: color4,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          hintText: widget.label,
          prefixIcon: widget.prefixIcon,
          prefixIconColor: color4,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 60, minHeight: 60),
          hintStyle: TextStyle(fontSize: 18, color: color4),
        ),
      ),
    );
  }
}
