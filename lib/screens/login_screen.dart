import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/otherSignIn.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  final _auth = FirebaseAuth.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  bool loading = false;
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ModalProgressHUD(
        progressIndicator: SpinKitChasingDots(
          color: Theme.of(context).primaryColor,
        ),
        inAsyncCall: loading,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 60.0,
                              child: Image.asset('images/logo.png')),
                          const SizedBox(width: 10.0),
                          Text(
                            'Chateo',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 65),
                          )
                        ],
                      ),
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
                        email = value;
                        //Do something with the user input.
                      },
                      style: Theme.of(context).textTheme.bodyLarge,
                      cursorColor:
                          Theme.of(context).primaryColorDark.withOpacity(0.6),
                      decoration: getInputDecor('Enter your email')),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                        //Do something with the user input.
                      },
                      style: Theme.of(context).textTheme.bodyLarge,
                      cursorColor:
                          Theme.of(context).primaryColorDark.withOpacity(0.6),
                      decoration: getInputDecor('Enter your password')),
                  Text(errorText, style: kErrorStyle1()),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Center(
                    child: Text(
                      'OR',
                      style: kBodyStyle1(color: const Color(0xFFADB5BD)),
                    ),
                  ),
                  getImageButton(
                    'Sign In with Google',
                    context: context,
                    onPressed: () async {
                      final userCred = await signInWithGoogle();
                      if (userCred.user != null) {
                        if (userCred.user?.emailVerified == true) {
                          final callable =
                              _functions.httpsCallable('getStreamUserToken');
                          final results = await callable();
                          print('Stream user token retrieved: ${results.data}');
                          if (userCred.user != null) {
                            Navigator.pushNamed(context, '/home');
                          }
                        } else {
                          Navigator.pushNamed(context, '/verify');
                        }
                      }
                    },
                    image: 'google.png',
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  getButton('Log In', context: context, onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      final userCred = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (userCred.user != null) {
                        if (userCred.user?.emailVerified == true) {
                          final callable =
                              _functions.httpsCallable('getStreamUserToken');
                          final results = await callable();
                          print('Stream user token retrieved: ${results.data}');
                          if (userCred.user != null) {
                            Navigator.pushNamed(context, '/home');
                          }
                        } else {
                          Navigator.pushNamed(context, '/verify');
                        }
                      }
                    } catch (e) {
                      setState(() {
                        errorText = e.toString();
                      });
                    }
                    setState(() {
                      loading = false;
                    });
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
