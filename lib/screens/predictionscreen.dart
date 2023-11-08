import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MoreDetailsScreen extends StatefulWidget {
  final Uint8List imageBytes;
  final String tagName;
  final double probability;

  MoreDetailsScreen(
      {required this.imageBytes,
        required this.tagName,
        required this.probability});

  @override
  _MoreDetailsScreenState createState() => _MoreDetailsScreenState();
}

class _MoreDetailsScreenState extends State<MoreDetailsScreen> {
  late Image image;
  double? imageWidth;
  double? imageHeight;

  late String Biological = "";
  late String Chemical = "";
  late String Disease = "";
  late String Description = "";



  @override
  void initState() {
    super.initState();
    image = Image.memory(widget.imageBytes);
    imageWidth = image.width?.toDouble();
    imageHeight = image.height?.toDouble();
    fetchDetails();
  }

  void fetchDetails() async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance
        .collection('Solutions')
        .where("Disease", isEqualTo: widget.tagName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var solutions = querySnapshot.docs.first;
        setState(() {
          Biological = solutions['Biological'].toString();
          Chemical = solutions['Chemical'].toString();
          Description= solutions['Description'].toString();
        });
      }
    }).catchError((error) {
      print('Error fetching details: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Color(0xFF1F3D1D),

        ),
        body: Column(
            children: [
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  width: imageWidth,
                  height: imageHeight,
                  child: Image.memory(widget.imageBytes, fit: BoxFit.fitWidth),
                ),
              ),
              SizedBox(height: 20.0),
              Divider(
                height: 5.0,
                color: Colors.black,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(right: 225),
                        child: Text(
                          '${widget.tagName}',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        constraints: BoxConstraints(
                          minHeight: 0,
                          maxHeight: double.infinity,
                        ),
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF1F3D1D),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                Description,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        constraints: BoxConstraints(
                          minHeight: 0,
                          maxHeight: double.infinity,
                        ),
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF439143),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFF439143),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Biological Solution',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                Biological,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        constraints: BoxConstraints(
                          minHeight: 0,
                          maxHeight: double.infinity,
                        ),
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF1F3D1D),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chemical Solution',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                Chemical,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            ),
        );
  }
}