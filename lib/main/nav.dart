import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_get_serious/main/settings_page.dart';
import 'package:lets_get_serious/tools/design.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lets_get_serious/main/camera.dart';
import 'package:lets_get_serious/main/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Nav extends StatefulWidget {
  final int index;

  const Nav({super.key, required this.index});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  // const HomePage({super.key});
  int currentPageIndex = 0;

  void setPageIndex(int index) {
    currentPageIndex = index;
  }

  final navPages = [HomePage(), CameraPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Scaffold(
      backgroundColor: backgroundGradientColor1,
      body: navPages[currentPageIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: color1,
          splashColor: Colors.transparent,
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              gradient: backgroundGradient,
          ),
          child: GNav(
            duration: Duration(milliseconds: 250),
            color: color4,
            activeColor: color2,
            backgroundColor: Color(0xFF171C1F),
            tabBackgroundColor: color4,
            tabMargin: EdgeInsets.all(10),
            textStyle: TextStyle(
              fontFamily: 'Product Sans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color2,
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            mainAxisAlignment: MainAxisAlignment.center,
            selectedIndex: currentPageIndex,
            onTabChange: (value) {
              setState(() {
                currentPageIndex = value;
              });
            },
            gap: 10,
            tabs: [
              GButton(icon: FontAwesomeIcons.house, text: "Home"),
              GButton(icon: FontAwesomeIcons.camera, text: "Find"),
              GButton(icon: Icons.settings_outlined, text: "Settings"),
            ],
          ),
        ),
      ),
    );
  }
}
