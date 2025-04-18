import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_get_serious/tools/design.dart';

class InputDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onRename;
  const InputDialog(
      {super.key, required this.controller, required this.onRename});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration:
            BoxDecoration(color: color3, borderRadius: defaultBorderRadius),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rename plant",
              style: TextStyle(
                  fontFamily: 'Product Sans',
                  color: color4,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              autocorrect: true,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: color4)),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: color4)),
                label: Text(
                  "New name",
                  style: TextStyle(
                      fontFamily: 'Product Sans', fontSize: 18, color: color4),
                ),
              ),
              style: TextStyle(
                  fontFamily: 'Product Sans', fontSize: 18, color: color4),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onRename,
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(color4),
                      foregroundColor: WidgetStatePropertyAll(color2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    FaIcon(FontAwesomeIcons.check, size: 20,),
                    SizedBox(width: 10),
                    Text("Rename")
                  ]),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(color4),
                        foregroundColor: WidgetStatePropertyAll(color2)),
                    onPressed: () {
                      controller.clear();
                      Navigator.pop(context);
                    },
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    FaIcon(FontAwesomeIcons.ban, size: 20,),
                    SizedBox(width: 10),
                    Text("Cancel")
                  ]),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
