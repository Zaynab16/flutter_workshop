import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color(0xFF1F3D1D),
            child: Center(
              child:  Image.asset(
                'assets/images/logo2.png',
                height: 200, width: 200,
              ),
            ),
            )
        );

  }
}