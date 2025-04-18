import 'package:flutter/material.dart';
import 'package:lets_get_serious/main/nav.dart';
import 'package:lets_get_serious/tools/design.dart';

class UploadedPlantPage extends StatefulWidget {
  const UploadedPlantPage({super.key});

  @override
  State<UploadedPlantPage> createState() => _UploadedPlantPageState();
}

class _UploadedPlantPageState extends State<UploadedPlantPage> {
  double? soilMoisture;
  double? temperature;
  double? humidity;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Nav(
              index: 0,
            ),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Capture Diagnosis',
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Placeholder(
                fallbackHeight: 300,
              ),
              SizedBox(height: 20),
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
                      'Info',
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
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  gradient: secondaryGradient,
                  borderRadius: defaultBorderRadius,
                  border: Border.all(color: color4, width: 3),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Predicted",
                              style: TextStyle(
                                color: color4,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Early Blight",
                              style: TextStyle(
                                color: color4,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Confidence",
                              style: TextStyle(
                                color: color4,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "50%", //TODO add confidence from api
                              style: TextStyle(
                                color: color4,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {}, //TODO add function
                style: ElevatedButton.styleFrom(
                  backgroundColor: color2,
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  side: const BorderSide(color: Color(0xFFD8E4FF)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'New',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xFFD8E4FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
