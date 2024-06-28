import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isFirstAnimationComplete = false;
  @override
  void initState() {
    super.initState();
    // Set a delay to start the second animation after the first completes
    Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        _isFirstAnimationComplete = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: [
                const SizedBox(height: 100.0),
                SizedBox(height: 250.0, child: Image.asset('images/first.png')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: SizedBox(
                        height: 40.0,
                        child: Image.asset('images/logo.png')
                            .animate()
                            .scale(
                              duration: 1.seconds,
                              begin: const Offset(0.5, 0.5),
                              end: const Offset(1.5, 1.5),
                              curve: Curves.bounceOut,
                            )
                            .fade(
                              duration: 1.seconds,
                            ),
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Chateo',
                          textStyle: kHeadingStyle1(fontSize: 45.0),
                          speed: const Duration(milliseconds: 500),
                        ),
                      ],
                      pause: const Duration(minutes: 2),
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ],
                ),
                if (_isFirstAnimationComplete)
                  Text(
                    'Connecting you with the world!',
                    textAlign: TextAlign.center,
                    style: kHeadingStyle1(
                        fontSize: 20.0, color: const Color(0xFF0F1828)),
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
            Column(
              children: [
                getButton('Register', onPressed: () {
                  Navigator.pushNamed(context, '/register');
                }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextButton(
                    onPressed: () {
                      //Go to login screen.
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Log In', style: kSubheadingStyle1()),
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
