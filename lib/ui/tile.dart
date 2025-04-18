import 'package:flutter/material.dart';
import 'package:lets_get_serious/tools/design.dart';

class IconTile extends StatelessWidget {
  const IconTile(
      {super.key,
      required this.label,
      required this.icon,
      required this.pressCallback, required this.iconScale});
  final String label;
  final IconData icon;
  final double iconScale;
  final VoidCallback pressCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: pressCallback,
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    gradient: secondaryGradient,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(5, 5), blurRadius: 3, color: color7)
                    ],
                    border: Border.all(color: color4, width: 3),
                    shape: BoxShape.circle),
                padding: EdgeInsets.all(15),
                child: Icon(icon, size: iconScale, color: color4,)),
            Text(
              label,
              style: TextStyle(
                  fontFamily: 'Product Sans', color: color4, fontSize: 25),
            )
          ],
        ));

    // return IconButton(onPressed: () {}, icon: icon);
    // return ;
  }
}
