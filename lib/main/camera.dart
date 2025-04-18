import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'package:lets_get_serious/tools/design.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  XFile? _image;
  String mainUrl = 'https://web-production-0cf7c.up.railway.app/api/';
  bool isLoading = false;
  String errorMessage = '';
  List<dynamic> data = [];
  var uuid = Uuid();
  String uniqueId = '';

  Future<Map<String, dynamic>?> fetchObjectById(String id) async {
    final url = Uri.parse('https://web-production-0cf7c.up.railway.app/api/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is List && data.isNotEmpty) {
          for (var user in data) {
            if (user['image_id'] == uniqueId && user['predicted'] == true) {
              log(jsonEncode(user));
              return user;
            }
          }
        }
        return null;
      } else {
        log('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Exception: $e');
      return null;
    } finally {
      isLoading = false;
    }
  }

  Future<void> sendData(String url, Map<String, dynamic> dataToSend) async {
    try {
      isLoading = true;
      // Make an HTTP POST request to the provided URL with JSON data in the body
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type':
              'application/json', // Tell the server we are sending JSON data
        },
        body: json.encode(dataToSend), // Convert the data to JSON format
      );
      log(response.body);
      // Check if the response status code is 200 (success)
      if (response.statusCode == 201) {
        setState(() {
          // Decode the response body (if applicable)
          final decodedData = json.decode(response.body);

          // Handle response data (you can customize this part based on your API's response structure)
          if (decodedData is List) {
            data = decodedData;
          } else if (decodedData is Map) {
            data = [decodedData];
          }
        });
        log('Data sent successfully');
      } else {
        setState(() {
          // If status code isn't 200, set an error message with status code
          errorMessage = 'Failed to send data: ${response.statusCode}';
          
          log(errorMessage);
        });
      }
      fetchObjectById(uniqueId);
    } catch (e) {
      // Catch any error during the fetch operation
      setState(() {
        // Set the error message to show the exception
        errorMessage = 'Error: $e';
      });

      // Log the error for debugging
      log('Post error: $e');
    } finally {
      log(data.toString());
      isLoading = false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      // Create an instance of the ImagePicker class
      final picker = ImagePicker();

      // Use the pickImage method to allow the user to pick an image from the specified source
      final pickedFile = await picker.pickImage(source: source);

      // If the user cancels picking an image, pickedFile will be null, so return early
      if (pickedFile == null) return;

      // Update the state with the picked image
      setState(() {
        // Assuming _image is defined as XFile? _image; (nullable)
        _image = pickedFile; // Store the picked image file
      });
    } catch (e) {
      // Catch and log any errors that occur during the image picking process
      log("Error picking image: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: Container(
            alignment: Alignment.center,
            child: _image != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Photo Captured',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Color(0xFFD8E4FF),
                        ),
                      ),
                      Image.asset(
                        'assets/icons/Design_separator.png',
                      ),
                      SizedBox(height: 10),
                      _image == null
                          ? SizedBox()
                          : Image.file(File(_image!.path)),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: color6,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  uniqueId = uuid.v4();
                                  sendData(
                                    'https://web-production-0cf7c.up.railway.app/api/',
                                    {
                                      "image_id": uniqueId,
                                      "image": base64Encode(
                                        File(_image!.path).readAsBytesSync(),
                                      ),
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: color6),
                                icon: Icon(
                                  Icons.assignment_turned_in_outlined,
                                  color: color4,
                                ),
                                label: Text(
                                  'Accept',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Color(0xFFD8E4FF),
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: color6),
                                icon: Icon(
                                  Icons.restart_alt_outlined,
                                  color: color4,
                                ),
                                label: Text(
                                  'Retry',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Color(0xFFD8E4FF)),
                                ),
                              ),
                            ],
                          ))
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/Design_separator.png',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: color4),
                              gradient: secondaryGradient,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/camera.png',
                                ),
                                const Text(
                                  'Capture Method',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: color4,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Select how you would like to upload a photo.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: color4, fontSize: 20),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () =>
                                      pickImage(ImageSource.camera),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: color2,
                                    padding: const EdgeInsets.all(8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    side: const BorderSide(
                                        color: Color(0xFFD8E4FF)),
                                  ),
                                  child: Text(
                                    'open Camera',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Color(0xFFD8E4FF),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () =>
                                      pickImage(ImageSource.gallery),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: color2,
                                    padding: const EdgeInsets.all(8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    side: const BorderSide(
                                        color: Color(0xFFD8E4FF)),
                                  ),
                                  child: Text(
                                    'Pick from Gallery',
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
