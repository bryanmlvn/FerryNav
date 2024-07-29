import 'package:flutter/material.dart';
import 'package:ferrynav/screens/welcome_page.dart';
import 'package:ferrynav/screens/login_page.dart'; // Ensure this path is correct
// import 'package:screens/registration_page.dart'; // Ensure this path is correct

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginPage.id: (context) => LoginPage(),
        // RegistrationPage.id: (context) => RegistrationPage(), // Add this route
      },
    );
  }
}
