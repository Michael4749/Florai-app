import 'package:flutter/material.dart';

import 'package:lets_get_serious/tools/design.dart';

import '../config/widgets/my_textfield.dart';
import 'nav.dart';

class AddPlant extends StatefulWidget {
  AddPlant({super.key});

  @override
  State<AddPlant> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  final nameController = TextEditingController();
  final idController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    idController.dispose();
  }

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
                  'Add New Plant',
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
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: color4),
                        borderRadius: BorderRadius.circular(20),
                        gradient: secondaryGradient,
                      ),
                      child: Column(
                        spacing: 10,
                        children: [
                          const Text(
                            'Plant Name',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: color4,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
                          MyTextField(
                            controller: nameController,
                            obscureText: false,
                            label: 'Plant Name',
                            color: color2,
                          ),
                          MyTextField(
                            controller: idController,
                            obscureText: false,
                            label: 'ID',
                            color: color2,
                          ),
                          ElevatedButton(
                            onPressed: () {},//TODO add function to save plant
                            style: ElevatedButton.styleFrom(
                              backgroundColor: color2,
                              padding: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              side: const BorderSide(color: Color(0xFFD8E4FF)),
                            ),
                            child: Text(
                              'Connect',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Color(0xFFD8E4FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
