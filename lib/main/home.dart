import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_get_serious/tools/design.dart';
import 'package:lets_get_serious/ui/tile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'profile.dart';
import 'add_plant.dart';
import 'plant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user = FirebaseAuth.instance.currentUser;

  final plants = [
    {"name": "Plant 1", "icon": FontAwesomeIcons.sun},
    {"name": "Plant 2", "icon": FontAwesomeIcons.sun},
    {"name": "Plant 3", "icon": FontAwesomeIcons.sun},
    {"name": "Plant 4", "icon": FontAwesomeIcons.sun},
    {"name": "Plant 5", "icon": FontAwesomeIcons.sun},
    {"name": "Plant 6", "icon": FontAwesomeIcons.sun},
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) async {
        exit(0);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(gradient: backgroundGradient),
              alignment: Alignment.center,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/vectors/bg_deco.svg',
                width: 410,
                excludeFromSemantics: true,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        gradient: secondaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: defaultBoxShadow),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            user!.photoURL == null
                                ? Image.asset('assets/icons/icon.png',
                                    width: 40)
                                : ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: Image.network(user!.photoURL!,
                                        width: 40),
                                  ),
                            SizedBox(width: 10),
                            Text(
                              'Hello, ${user!.displayName}',
                              style: TextStyle(
                                fontFamily: 'Product Sans',
                                color: color4,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.settings_outlined,
                            color: color4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: secondaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: defaultBoxShadow),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'My plants',
                                style: titleStyle,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddPlant(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: color4,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          SizedBox(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.8,
                              ),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: plants.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: IconTile(
                                    label: plants[index]['name'] as String,
                                    icon: plants[index]['icon'] as IconData,
                                    iconScale: 40,
                                    pressCallback: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PlantPage(),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
