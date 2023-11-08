import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_workshop/screens/predictionscreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

const String predictionKey = '8d32098ef5dd4f759af8286882aeafbd';



class WallpaperPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    Future<List<dynamic>> performCustomVisionPrediction(File imageFile) async {
      final url =
      Uri.parse('https://workshopppp-prediction.cognitiveservices.azure.com/customvision/v3.0/Prediction/fdcf933c-5f27-4537-9d58-905666028c17/detect/iterations/Iteration1/image');

      final headers = {
        'Content-Type': 'application/octet-stream',
        'Prediction-Key': '8d32098ef5dd4f759af8286882aeafbd',
      };

      final bytes = await imageFile.readAsBytes();
      final response = await http.post(url, headers: headers, body: bytes);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['predictions'];
      } else {
        throw Exception('Failed to perform custom vision prediction. ${response.statusCode}');
      }
    }


    Future<void> _getImage(ImageSource source) async {
      PermissionStatus status = await Permission.camera.status;
      if (!status.isGranted) {
        status = await Permission.camera.request();
        if (!status.isGranted) {
          return;
        }
      }

      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: source);
      print('Image path: ${pickedFile?.path}');

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        final predictions = await performCustomVisionPrediction(imageFile);

        if (pickedFile != null) {
          final imageFile = File(pickedFile.path);
          final predictions = await performCustomVisionPrediction(imageFile);

          // Find prediction with highest probability
          dynamic highestPrediction;
          double highestProbability = 0.0;
          for (final prediction in predictions) {
            final probability = prediction['probability'];
            if (probability > highestProbability) {
              highestPrediction = prediction;
              highestProbability = probability;
            }
          }

          // Extract the image and probability data
          Uint8List imageBytes = await imageFile.readAsBytes();
          String tagName = highestPrediction['tagName'];
          double probability = highestPrediction['probability'];

          // Show dialog box with prediction information
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Diagnosis',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Color(0xFF1F3D1D),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Disease: $tagName\nProbability: ${probability.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: TextButton(
                          child: Text('Diagnose', style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MoreDetailsScreen(
                                  imageBytes: imageBytes,
                                  tagName: tagName,
                                  probability: probability,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

          print('Predictions:');
          for (final prediction in predictions) {
            final tagName = prediction['tagName'];
            final probability = prediction['probability'];
            print('$tagName: Probability: ${probability.toStringAsFixed(2)}');
          }
        }
      }
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffefdada),
                    Color(0xFF1D6A35),
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 50.0, vertical: 160.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.only(top: 25.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Hi! Welcome to Leaf-It',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xFF1D6A35),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 5.0),
                          child: Text(
                            'With just one photo, Leaf-It diagnoses infected indigenous plants and offers treatment for any disease.',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, left: 15.0),
                              child: Text(
                                'Heal your plants!',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xFF1D6A35),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      image:
                                      AssetImage('assets/image/scan.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Icon(
                                  FontAwesomeIcons.chevronRight,
                                  color: Color(0xFF1D6A35),
                                  size: 15,
                                  weight: 40,
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/image/clipboard.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Icon(
                                  FontAwesomeIcons.chevronRight,
                                  color: Color(0xFF1D6A35),
                                  size: 15,
                                  weight: 40,
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      image:
                                      AssetImage('assets/image/heal.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Choose an option'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            GestureDetector(
                                              child: Text('Camera'),
                                              onTap: () {
                                                _getImage(ImageSource.camera);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            SizedBox(height: 10.0),
                                            GestureDetector(
                                              child: Text('Gallery'),
                                              onTap: () {
                                                _getImage(ImageSource.gallery);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 165,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Color(0xFF1D6A35),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 17.0),
                                      child: Icon(
                                        FontAwesomeIcons.camera,
                                        color: Colors.white,
                                        size: 15,
                                        weight: 40,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 17.0),
                                      child: Text(
                                        'Take a picture',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}