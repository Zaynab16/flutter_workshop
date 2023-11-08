
import 'package:flutter/material.dart';
import 'package:flutter_workshop/screens/event.dart';
import 'package:flutter_workshop/screens/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'contact.dart';
import 'diagnose.dart';
import 'map.dart';
import 'newchatbot.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isSpread = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height - 80;
    final backgroundColor = Color(0xFFE7EFE4);
    final darkgreen = Color(0xFF1F3D1D);

    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 80,
          title: Text(
            'Leaf It',
            style: TextStyle(fontSize: 27),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false, // Remove the drawer
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [Color(0xFF2E5B41), darkgreen],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        body: Stack(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Column(
                            children: [
                              SizedBox(height: 110),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Diagnose(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  height: screenHeight * 0.26,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: Image.asset('assets/images/4.png').image,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [Color(0xFF2E5B41), Color(0xFFB2B981)],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EventsLists(),
                                    ),
                                  );
                                },

                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  height: screenHeight * 0.41,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: Image.asset('assets/images/event.png').image,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [darkgreen, Color(0xFF51713A), Color(0xFFCEC8C0)],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Discover(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  height: screenHeight * 0.41,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: Image.asset('assets/images/map2.png').image,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [darkgreen, Color(0xFF51713A), Color(0xFFCEC8C0)],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatbotScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  height: screenHeight * 0.26,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: Image.asset('assets/images/chatbot.png').image,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [Color(0xFF2E5B41), Color(0xFFB2B981)],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isSpread = !isSpread;
                    });
                  },
                  child: SizedBox(
                    width: isSpread ? 120.0 : 56.0,
                    height: 56.0,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(isSpread ? 30.0 : 28.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          if (isSpread) ...[
                            Consumer<ThemeNotifier>(
                              builder: (context, themeNotifier, _) {
                                final _isDarkTheme = themeNotifier.getTheme().brightness == Brightness.dark;

                                void _toggleTheme(bool value) async {
                                  await themeNotifier.setTheme(value);
                                }

                                return GestureDetector(
                                  onTap: () {
                                    _toggleTheme(!_isDarkTheme); // Toggle the theme when lightbulb is tapped
                                  },
                                  child: Icon(
                                    Icons.lightbulb_outline_sharp,
                                    color: _isDarkTheme ? Color(0xFFF5C91D) : Colors.grey, // Change color based on theme
                                  ),
                                );
                              },
                            ),
                            SizedBox(width:10,),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => contact(),
                                  ),
                                );
                              },
                              child: Icon(Icons.info,color: Colors.black,),
                            ),
                          ],
                          Expanded(
                            child: Icon(Icons.menu,color: Colors.black,),
                          ),
                          SizedBox(width:10,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
            ),
        );
    }
}