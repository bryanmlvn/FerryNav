import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ferrynav/screens/welcome_page.dart';
import 'package:ferrynav/screens/login_page.dart';
import 'package:ferrynav/screens/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FerryNavApp());
}

class FerryNavApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
      },
    );
  }
}
