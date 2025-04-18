import 'package:flutter/material.dart';
import 'package:lets_get_serious/tools/design.dart';

import 'nav.dart';

class InfoPage extends StatelessWidget {
  InfoPage({super.key});

  final credits = [
    {
      "name": "Michael Medhat",
      "role": "Flutter Developer",
      "icon": "assets/images/credits_icons/michael.png",
      "link": ""
    },
    {
      "name": "Fares Mostafa",
      "role": "UI/UX - Embedded",
      "icon": "assets/images/credits_icons/fares.png",
      "link": ""
    },
    {
      "name": "Ali Sobhy",
      "role": "AI Model - Embedded - UI/UX",
      "icon": "assets/images/credits_icons/ali.png",
      "link": ""
    },
    {
      "name": "Abdel-Aziz Qutb",
      "role": "API Development",
      "icon": "assets/images/credits_icons/qutb.png",
      "link": ""
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'App Info',
                    style: TextStyle(color: color4),
                  ),
                ],
              ),
              Divider(thickness: 3, color: color4),
            ],
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: color4,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Nav(
                    index: 0,
                  ),
                ),
              );
            },
          ),
          backgroundColor: backgroundGradientColor1,
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: backgroundGradient),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/icon.png'),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Image.asset('assets/icons/florai_icon.png'),
                        Text(
                          'APP version 1.0',//TODO add version from firebase
                          style: TextStyle(
                              fontSize: 20,
                              color: color4,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ]
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: color4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Credits',
                        style: TextStyle(
                            fontSize: 20,
                            color: color4,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: color4,
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  itemCount: credits.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: color2, borderRadius: defaultBorderRadius),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 3, color: color4)),
                              child: CircleAvatar(
                                foregroundImage: AssetImage(
                                    credits[index]['icon'] as String),
                                radius: 40,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(credits[index]['name'] as String,
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        color: color4,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text(credits[index]['role'] as String,
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        color: color4,
                                        fontSize: 13)),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            )));
  }
}
