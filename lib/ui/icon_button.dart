import 'package:flutter/material.dart';
import '../tools/design.dart';

class ThemedIconButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final VoidCallback pressCallback;
  const ThemedIconButton(
      {super.key,
      required this.text,
      this.icon = const Icon(Icons.question_mark_outlined, size: 50),
      required this.pressCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
          onPressed: pressCallback,
          style: ButtonStyle(
              enableFeedback: false,
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.black),
              side: WidgetStatePropertyAll(defaultStroke),
              padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
              backgroundColor: WidgetStatePropertyAll(color2),
              foregroundColor: WidgetStatePropertyAll(color4),
              shape: WidgetStatePropertyAll(defaultBorder)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon,
              Text(
                text,
                style: TextStyle(fontSize: 40, fontFamily: 'Product Sans'),
              )
            ],
          )),
    );
  }
}
