import 'package:lets_get_serious/tools/design.dart';
import 'package:lets_get_serious/ui/button.dart';
import 'package:lets_get_serious/main/nav.dart';
import 'package:flutter/material.dart';

class PlantPage extends StatefulWidget {
  const PlantPage({super.key});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
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
                    'plant_name',
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
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(gradient: backgroundGradient),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Placeholder(),
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
                      'Status',
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width / 1.3,
                        decoration: BoxDecoration(
                          gradient: secondaryGradient,
                          borderRadius: defaultBorderRadius,
                          border: Border.all(color: color4),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          spacing: 45,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Climate',
                                  style: TextStyle(fontSize: 18, color: color4),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.ac_unit_outlined,
                                  color: color4,
                                ),
                                Text(
                                  '50℃ ',
                                  style: TextStyle(color: color4),
                                ),
                                Icon(
                                  Icons.circle,
                                  color: color4,
                                  size: 5,
                                ),
                                Text(
                                  ' 50%',
                                  style: TextStyle(color: color4),
                                ),
                              ],
                            ), //TODO add data from api
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        width: 150,
                        decoration: BoxDecoration(
                            gradient: secondaryGradient,
                            borderRadius: defaultBorderRadius,
                            border: Border.all(color: color4)),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          spacing: 45,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.ac_unit_outlined,
                                  color: color4,
                                ),
                                Text(
                                  'Soil Moisture',
                                  style: TextStyle(fontSize: 14, color: color4),
                                ),
                              ],
                            ),
                            Text(
                              '50%',
                              style: TextStyle(color: color4),
                            ), //TODO add data from api
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            gradient: secondaryGradient,
                            borderRadius: defaultBorderRadius,
                            border: Border.all(color: color4)),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          spacing: 45,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  color: color4,
                                ),
                                Text(
                                  'Last Updated',
                                  style: TextStyle(fontSize: 14, color: color4),
                                ),
                              ],
                            ),
                            Text(
                              '1H',
                              style: TextStyle(color: color4),
                            ), //TODO add time from api
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Button(text: 'Update', pressCallback: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
