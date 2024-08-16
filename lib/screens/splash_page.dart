// import 'package:ferrynav/screens/seat_page.dart';
// import 'package:ferrynav/screens/ticketdetails_page.dart';
import 'package:ferrynav/navigation_menu.dart';
import 'package:ferrynav/screens/home_page.dart';
import 'package:ferrynav/screens/login_page.dart';
import 'package:ferrynav/screens/seat_page.dart';
import 'package:flutter/material.dart';
import 'welcome_page.dart'; // Ensure you have the correct import for WelcomeScreen

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
  }

  _navigateToWelcome() async {
    await Future.delayed(
        Duration(milliseconds: 1800), () {}); // Simulate a delay
    Navigator.pushReplacementNamed(context, WelcomeScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF06305A),
      body: Center(
        child: Image.asset('assets/4.png'),
      ),
    );
  }
}
