import 'package:flutter/material.dart';
enum SelectedIcon {none, facebook, phone, email}
class contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClassScreen(),
    );
  }
}

class ClassScreen extends StatefulWidget {
  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  SelectedIcon _selectedIcon = SelectedIcon.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Image.asset(
                  'assets/images/Contact.png',
                  width: 300,
                  height: 300,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'In case of emergencies, we strongly encourage you to contact us via email. Email allows us to provide immediate assistance and address your concerns promptly. Our dedicated team is available 24/7 to respond to your emergency emails and provide the support you need. Please send your email to Gazo@example.com, and we will prioritize your request.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    height: 2,

                  ),
                ),
              ),
              SizedBox(height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIcon =
                        _selectedIcon == SelectedIcon.facebook
                            ? SelectedIcon.none
                            : SelectedIcon.facebook;
                      });
                    },
                    child: Icon(
                      Icons.facebook,
                      color: _selectedIcon == SelectedIcon.facebook
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIcon = _selectedIcon == SelectedIcon.phone
                            ? SelectedIcon.none
                            : SelectedIcon.phone;
                      });
                    },
                    child: Icon(
                      Icons.phone,
                      color: _selectedIcon == SelectedIcon.phone
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIcon = _selectedIcon == SelectedIcon.email
                            ? SelectedIcon.none
                            : SelectedIcon.email;
                      });
                    },
                    child: Icon(
                      Icons.email,
                      color: _selectedIcon == SelectedIcon.email
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        );
    }
}