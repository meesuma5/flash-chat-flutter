<<<<<<< Updated upstream
import 'package:flutter/material.dart';
=======
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart'
    as stream_chat;
>>>>>>> Stashed changes

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

<<<<<<< Updated upstream
class _WelcomeScreenState extends State<WelcomeScreen> {
=======
class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isFirstAnimationComplete = false;
  final _auth = FirebaseAuth.instance;
  final _functions = FirebaseFunctions.instance;
  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) async {
      if (user != null && user.emailVerified && user.displayName != null) {
        final callable = _functions.httpsCallable('getStreamUserToken');
        final results = await callable();
        final token = results.data;
        logger.i('Stream token retrieved, token: $token');
        final client = stream_chat.StreamChatCore.of(context).client;
        client.connectUser(
            stream_chat.User(
                id: _auth.currentUser!.uid,
                name: _auth.currentUser!.displayName,
                extraData: {
                  'email': _auth.currentUser!.email,
                },
                image: _auth.currentUser!.photoURL),
            token);
        Navigator.pushNamed(context, '/home');
      } else if (user != null && user.emailVerified) {
        Navigator.pushNamed(context, '/update_details');
      } else if (user != null) {
        Navigator.pushNamed(context, '/verification');
      } else {
        logger.i('User is currently signed out!');
      }
    });
    // Set a delay to start the second animation after the first completes
    Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        _isFirstAnimationComplete = true;
      });
    });
  }

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Image.asset('images/logo.png'),
                  height: 60.0,
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
<<<<<<< Updated upstream
=======
                  const SizedBox(
                    height: 10,
                  ),
                  if (_isFirstAnimationComplete)
                    Text(
                      'Connecting you with the world!',
                      textAlign: TextAlign.center,
                      style: kHeadingStyle1(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColorDark),
                    )
                        .animate()
                        .slideY(
                          duration: 1.seconds,
                          begin: 1.0,
                          end: 0.0,
                          curve: Curves.easeInOut,
                        )
                        .fade(
                          duration: 1.seconds,
                        )
                ],
              ),
              SafeArea(
                bottom: true,
                top: false,
                child: Column(
                  children: [
                    getButton('Register', context: context, onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    }),
                    TextButton(
                      onPressed: () {
                        //Go to login screen.
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Log In',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
>>>>>>> Stashed changes
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
