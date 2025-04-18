import 'package:flutter/material.dart';

import '../../tools/design.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final Icon? prefixIcon;
  final Color? color;

  const MyTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    this.prefixIcon,
    required this.label,
    this.color,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        style: const TextStyle(color: color4),
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          fillColor: widget.color ?? color6,
          filled: true,
          hintText: widget.label,
          prefixIcon: widget.prefixIcon,
          prefixIconColor: color4,
          hintStyle: TextStyle(
            fontSize: 18,
            color: color4,
          ),
        ),
      ),
    );
  }
}
