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
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: [
                  const SizedBox(height: 100.0),
                  SizedBox(
                      height: 250.0,
                      child: MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? Image.asset('images/first_dark.png')
                          : Image.asset('images/first.png')),
                  Hero(
                    tag: 'logo',
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 45.0,
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
                          const SizedBox(width: 20.0),
                          AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'Chateo',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontSize: 45),
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
                    ),
                  ),
                  if (_isFirstAnimationComplete)
                    SizedBox(
                      height: 10,
                    ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
