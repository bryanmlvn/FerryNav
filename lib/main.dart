import 'package:flutter/material.dart';
import 'package:ferrynav/screens/welcome_page.dart';
import 'package:ferrynav/screens/login_page.dart';
import 'package:ferrynav/screens/register_page.dart';

void main() {
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
