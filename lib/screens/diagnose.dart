import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workshop/screens/predictionscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Diagnose extends StatefulWidget {
  const Diagnose({Key? key}) : super(key: key);

  @override
  State<Diagnose> createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  String selectedImagePath = '';
  String predictionResult = '';
  double predictionProbability = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7EFE4),
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Text('Leaf It',
            style: TextStyle(fontSize: 27, color: Color(0xFFF5F4F0))),
        centerTitle: true,
        automaticallyImplyLeading: false, // Remove the drawer
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF1F3D1D), Color(0xFF1F3D1D)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: SizedBox(),
        ),
      ),
      body: Stack(children: [
        Column(
          children: [
            Container(
                height: (MediaQuery.of(context).size.height - 80) * 0.57,
                width: MediaQuery.of(context).size.width,
                color: Color(0xFF1F3D1D),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          selectedImagePath.isEmpty ? '' : 'Ready to diagnose!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Color(0xFFE7EFE4)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        selectedImagePath == ''
                            ? Image.asset(
                                'assets/images/image_placeholder.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.height * 0.3,
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                File(selectedImagePath),
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.height * 0.3,
                                fit: BoxFit.fill,
                              ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          selectedImagePath.isEmpty
                              ? 'Please upload your picture'
                              : 'Press Diagnose to continue',
                          style: TextStyle(
                              fontSize: 20.0, color: Color(0xFFE7EFE4)),
                        ),
                      ]),
                )),
          ],
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                  height:
                      ((MediaQuery.of(context).size.height - 80) * 0.57) - 28),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF5e8c24)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: 14, color: Colors.white)),
                ),
                onPressed: () async {
                  selectImage();
                  setState(() {});
                },
                child: Text(
                  selectedImagePath.isEmpty ? 'Upload' : 'Upload Another',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Color(0xFFF5F4F0)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              if (selectedImagePath.isNotEmpty)
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF5e8c24)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  onPressed: () {
                    if (selectedImagePath.isNotEmpty) {
                      diagnoseImage();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select an image first.'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Diagnose',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Color(0xFFF5F4F0)),
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> diagnoseImage() async {
    final url = Uri.parse(
        'https://eastus.api.cognitive.microsoft.com/customvision/v3.0/Prediction/772bbc53-769c-4632-a8d8-adb072161c1f/classify/iterations/Iteration2/image');

    final headers = {
      'Content-Type': 'application/octet-stream',
      'Prediction-Key': 'da2c41d3f0bc45718b46f39d859db7fe',
    };

    final imageBytes = await File(selectedImagePath).readAsBytes();

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: imageBytes,
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final predictions = decodedResponse['predictions'];

        if (predictions.isNotEmpty) {
          final prediction = predictions[0];
          final tagName = prediction['tagName'];
          final probability = prediction['probability'];

          setState(() {
            predictionResult = tagName;
            predictionProbability = probability * 100;
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Prediction Result'),
                content: Text(
                    'Tag: $predictionResult\nProbability: $predictionProbability%'),
                actions: [
                  if(tagName=='Powdery Mildew' || tagName=='Leaf Spot' || tagName=='Blight')
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoreDetailsScreen(
                          imageBytes: imageBytes,
                          tagName: predictionResult,
                          probability: predictionProbability,
                        ),
                      ),
                    ),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No predictions found.'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to diagnose image.'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
        ),
      );
    }
  }

  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_Path:-');
                            print(selectedImagePath);
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Image Selected !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/gallery.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_Path:-');
                            print(selectedImagePath);

                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/camera.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  //
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}
