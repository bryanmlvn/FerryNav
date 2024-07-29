import 'package:flutter/material.dart';
import 'package:ferrynav/components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login_page.dart'; // Ensure this file exists
// import 'registration_page.dart'; // Ensure this file exists

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_page';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Color(0xFFE1F7F5))
        .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: ClipOval(
                    child: Container(
                      child: Image.asset('assets/FerryNav.png'),
                      height: 200.0,
                      width: 200.0,
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Ferry Nav'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Color(0xFF0E46A3),
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: Color(0xFF0E46A3),
              onPressed: () {
                // Navigator.pushNamed(context, RegistrationPage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
