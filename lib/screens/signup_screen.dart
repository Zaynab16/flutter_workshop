import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workshop/screens/newchatbot.dart';
import '../utils/color_utils.dart';
import '../widgets/reusable_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("e6f7ff"),
                hexStringToColor("b3d1ff"),
                hexStringToColor("1a75ff")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
          child: Padding(
          padding: EdgeInsets.fromLTRB(
          20,MediaQuery.of(context).size.height*0.2, 20, 0),
      child: Column(
        children: <Widget>[
          logoWidget("assets/Image/num1.png"),
      const SizedBox(
      height: 30,
      ),
      reusableTextField("Enter UserName", Icons.person_outline, false,
          _userNameTextController),
      const SizedBox(
        height: 20,
      ),
          reusableTextField("Enter Email address", Icons.person_outline, false,
              _emailTextController),
          const SizedBox(
            height: 20,
          ),
      reusableTextField("Enter Password", Icons.lock_outlined, true,
          _passwordTextController),
      const SizedBox(
        height: 20,
      ),
      signInSignUpButton(context, false, () {
        //firebaseUIButton(context, "Sign Up", () {
          FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
              .then((value) {
            print("Created New Account");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatbotScreen()));
          }).onError((error, stackTrace) {
            print("Error ${error.toString()}");
          });

        })
      ],
    ),
    ))),
    );
    }
  }

