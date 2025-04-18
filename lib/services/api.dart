import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:flutter/material.dart';

class DataSender extends StatefulWidget {
  const DataSender({super.key});

  @override
  DataSenderState createState() => DataSenderState();
}

class DataSenderState extends State<DataSender> {
  bool isLoading = true;
  String errorMessage = '';
  List<dynamic> data = [];

  Future<void> sendData(String url, Map<String, dynamic> dataToSend) async {
    try {
      // Debug: Log the data you're sending
      log('Sending data: ${json.encode(dataToSend)}');

      // Make an HTTP POST request to the provided URL with JSON data in the body
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type':
              'application/json', // Tell the server we are sending JSON data
          // If the API requires an authentication header, add it here:
          // 'Authorization': 'Bearer YOUR_API_KEY',
        },
        body: json.encode(dataToSend), // Convert the data to JSON format
      );

      // Debug: Log the response status code and body
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      // Check if the response status code is 200 (success)
      if (response.statusCode == 200) {
        setState(() {
          // Decode the response body (if applicable)
          final decodedData = json.decode(response.body);

          // Handle response data (you can customize this part based on your API's response structure)
          if (decodedData is List) {
            data = decodedData;
          } else if (decodedData is Map) {
            data = [decodedData];
          }

          // Set 'isLoading' to false to indicate loading is complete
          isLoading = false;
        });
      } else {
        setState(() {
          // If status code isn't 200, set an error message with status code
          errorMessage = 'Failed to send data: ${response.statusCode}';
          isLoading = false; // Set 'isLoading' to false
        });
      }
    } catch (e) {
      // Catch any error during the fetch operation
      setState(() {
        // Set the error message to show the exception
        errorMessage = 'Error: $e';
        isLoading = false; // Set 'isLoading' to false
      });

      // Log the error for debugging
      log('Post error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Sender'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            if (data.isNotEmpty)
              Text(
                'Data received: ${data.toString()}',
                style: TextStyle(fontSize: 16),
              ),
            ElevatedButton(
              onPressed: () {
                // Call sendData with your desired URL and data
                sendData(
                  'https://myapi-production-566f.up.railway.app/api/',
                  {
                    "pk": 3,
                    "image":
                        "/uploads/Early_Blight_773_jpg.rf.b5ab87426f7ceca8b1bb1db1fae6c242.jpg",
                    "predict_class": "Early Blight",
                    "predict_accuracy": 95,
                    "predicted": false,
                  },
                );
              },
              child: Text('Send Data'),
            ),
          ],
        ),
      ),
    );
  }
}
