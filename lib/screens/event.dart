import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_workshop/screens/event_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workshop/screens/payment.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsLists extends StatefulWidget {
  const EventsLists({super.key});

  @override
  State<EventsLists> createState() => _EventsListsState();
}

class _EventsListsState extends State<EventsLists> {
  void _launchFacebook() async {
    const facebookUrl = 'https://www.facebook.com';
    try {
      await launch(facebookUrl);
    } catch (e) {
      throw 'Could not launch $facebookUrl:$e';
    }
  }
  EventRepository _eventRepository = EventRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Events'),
          backgroundColor:Color(0xFF1F3D1D),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: _eventRepository.getData(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                // ignore: unnecessary_cast
                final events = snapshot.data!.docs
                    .map((doc) =>
                    Events.fromJson(doc.data() as Map<String, dynamic>))
                    .toList();
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: events.length,
                    itemBuilder: (BuildContext context, int index) {
                      final event = events[index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(29),
                              color: Color(0xFF1F3D1D),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                event.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                  color: Color(0xFFE7EFE4),
                                                ),
                                              ),
                                              SizedBox(width: 15.0),
                                              Text(
                                                '-',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                  color: Color(0xFFE7EFE4),
                                                ),
                                              ),
                                              SizedBox(width: 10.0),
                                              Container(
                                                padding: EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20.0),
                                                  color: Colors.transparent,
                                                ),
                                                child: Text(
                                                  event.date,
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Color(0xFFE7EFE4),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Color(0xFFE7EFE4),
                                                size: 16.0,
                                              ),
                                              SizedBox(width: 4.0),
                                              Text(
                                                event.location,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Color(0xFFE7EFE4),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            event.description,
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                color: Color(0xFFE7EFE4)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      margin: EdgeInsets.only(right: 4.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Image.network(event.imageUrl,
                                              width: 100, height: 100),
                                          SizedBox(height: 8.0),
                                          Row(
                                              children: [
                                                SizedBox(height: 10.0),
                                                GestureDetector(
                                                  onTap: _launchFacebook,
                                                  child: Text(
                                                    'Tap to visit',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width:8,),
                                                Icon(
                                                  Icons.ads_click_outlined,
                                                  color: Color(0xFFE7EFE4),
                                                  size: 16.0,
                                                ),
                                              ],
                                              ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Center(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          Color(0xFF5e8c24)),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.only(
                                              right: 40,
                                              left: 40,
                                              top: 1,
                                              bottom: 1)),
                                      textStyle: MaterialStateProperty.all(
                                          const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DonationScreen()));
                                    },
                                    child: Text(
                                      'Donate',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Color(0xFFE7EFE4)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    });
              }),
        ));
  }
}

class Events {
  final String name;
  final String location;
  final String date;
  final String org;
  final String imageUrl;
  final String description;
  final String id;

  Events(
      {required this.name,
        required this.location,
        required this.date,
        required this.org,
        required this.imageUrl,
        required this.description,
        required this.id});

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
        name: json['Name'] as String,
        location: json['Location'] as String,
        date: json['Date'] as String,
        org: json['Organiser'] as String,
        imageUrl: json['imgUrl' as String],
        description: json['Description'] as String,
        id: json['id'] as String);
    }
}