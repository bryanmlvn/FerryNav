import 'package:flutter/material.dart';
import 'package:ferrynav/components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login_page.dart'; // Ensure this file exists
import 'register_page.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_page';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  bool animationComplete = false;

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

    // Set a timer to update the animationComplete flag
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          animationComplete = true;
        });
      }
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
      backgroundColor: Color(0xFFE1F7F5),
      body: Stack(
        children: <Widget>[
          // Background image at the lower part of the screen
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 1.0,
              child: Image.asset(
                'assets/welcome_bg.png',
                fit: BoxFit.cover,
                height: 300.0, // Adjust the height as needed
              ),
            ),
          ),
          // Main content
          Padding(
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
                          child: Image.asset('assets/FerryNav_Logo.png'),
                          height: 200.0,
                          width: 200.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0), // Add spacing between image and text
                    if (!animationComplete)
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black54,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            FadeAnimatedText(
                              'Welcome to FerryNav\nYour Online Ferry Booker',
                              duration: Duration(seconds: 2),
                              textAlign: TextAlign.center,
                              textStyle: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black54,
                              )
                            ),
                          ],
                          isRepeatingAnimation: false,
                          onFinished: () {
                            setState(() {
                              animationComplete = true;
                            });
                          },
                        ),
                      )
                    else ...[
                      Text(
                        'Welcome to FerryNav\nYour Online Ferry Booker',
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 80.0), // Spacing between text and buttons
                RoundedButton(
                  title: 'Log In',
                  colour: Color(0xFF0E46A3),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                  icon: Icon(Icons.person, color: Colors.white), // Add the icon here
                ),
                RoundedButton(
                  title: 'Register',
                  colour: Color(0xFF0E46A3),
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterPage.id);
                  },
                  icon: Icon(Icons.app_registration, color: Colors.white), // Add the icon here
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
