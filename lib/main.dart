import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import './screens/welcome_screen.dart';
import './screens/login_screen.dart';
import './screens/registration_screen.dart';
import 'screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Use the local Firebase Functions emulator
  FirebaseFunctions functions = FirebaseFunctions.instance;

  // Replace `10.0.2.2` with `localhost` if you're using an iOS simulator
  functions.useFunctionsEmulator('localhost', 5001);

  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.light(ThemeData.light()),
      darkTheme: AppTheme.dark(ThemeData.dark()),
      initialRoute: _auth.currentUser == null
          ? '/'
          : _auth.currentUser?.emailVerified == true
              ? '/home'
              : '/verify',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/home': (context) => const HomeScreen(),
        '/chat': (context) => const ChatScreen(),
        '/verify': (context) => VerificationScreen(),
      },
    );
  }
}
