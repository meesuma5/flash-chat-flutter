import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _auth = FirebaseAuth.instance;

  final _functions = FirebaseFunctions.instance;
  bool pop = false;
  late RestartableTimer timer;

  @override
  void initState() {
    super.initState();

    // ignore: unnecessary_set_literal
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer = RestartableTimer(Duration(seconds: 5), () async {
      await _auth.currentUser?.reload();
      print('reloading');
      if (_auth.currentUser?.emailVerified == true) {
        timer.cancel();
        final callable =
            _functions.httpsCallable('createStreamUserAndGetToken');
        final results = await callable();
        print('Stream account created, token: ${results.data}');
        Navigator.pushNamed(context, '/home');
      } else {
        timer.reset();
      }
    });
  }

  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                textAlign: TextAlign.center,
                'A verification link has been sent to your email. Please click on the link to verify.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Did not receive a link.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    style: null,
                    isSemanticButton: false,
                    onPressed: () {
                      _auth.currentUser?.sendEmailVerification();
                    },
                    child: Text(
                      'Click Here',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
            ),
            getButton('Sign Out', onPressed: () {
              _auth.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            }, context: context),
          ],
        ),
      ),
    );
  }
}
