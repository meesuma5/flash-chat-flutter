<<<<<<< Updated upstream
=======
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flash_chat/constants.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< Updated upstream
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200.0,
              child: Image.asset('images/logo.png'),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
=======
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
                    'Hi there! Let\'s Get You Registered',
                    style: kHeadingStyle2(fontSize: 22.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      style: Theme.of(context).textTheme.bodyLarge,
                      cursorColor:
                          Theme.of(context).primaryColorDark.withOpacity(0.6),
                      decoration: getInputDecor('Enter your email')),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      password = value;
                    },
                    style: Theme.of(context).textTheme.bodyLarge,
                    cursorColor:
                        Theme.of(context).primaryColorDark.withOpacity(0.6),
                    decoration: getInputDecor('Enter your password'),
                  ),
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
                      print(userCred.user);
                      if (userCred.user != null) {
                        if (userCred.user?.emailVerified == true) {
                          final callable = _functions
                              .httpsCallable('createStreamUserAndGetToken');
                          final results = await callable();
													final token = results.data;
                          print(
                              'Stream account created, token: $token');
                          Navigator.pushNamed(context, '/home', arguments: token);
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
                  getButton(
                    'Register',
                    context: context,
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      try {
                        final user = await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                        if (user.user != null) {
                          Navigator.pushNamed(context, '/verify');
                        }
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        loading = false;
                      });
                    },
                  )
                ],
>>>>>>> Stashed changes
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: InputDecoration(
                hintText: 'Enter your password',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Implement registration functionality.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
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
