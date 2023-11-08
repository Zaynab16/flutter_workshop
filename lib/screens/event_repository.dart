
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EventRepository extends GetxController {


  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance.collection("Events").get();
  }
}
