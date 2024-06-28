import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                Text(
                  'Enter Your Log In Credentials',
                  style: kHeadingStyle2(fontSize: 22.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 48.0,
                ),
                TextField(
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    style: kBodyStyle1(),
                    cursorColor: Colors.black.withOpacity(0.6),
                    decoration: getInputDecor('Enter your email')),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    style: kBodyStyle1(),
                    cursorColor: Colors.black.withOpacity(0.6),
                    decoration: getInputDecor('Enter your password')),
                const SizedBox(
                  height: 24.0,
                ),
                getButton('Log In', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
