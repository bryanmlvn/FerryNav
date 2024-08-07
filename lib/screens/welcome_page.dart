import 'package:flutter/material.dart';
import 'package:ferrynav/components/rounded_button.dart';
import 'login_page.dart';
import 'register_page.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_page';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD2FBF7),
      body: Stack(
        children: <Widget>[
          // Main content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 154.0),
                    Hero(
                      tag: 'logo',
                      child: ClipOval(
                        child: FadeTransition(
                          opacity: opacityAnimation,
                          child: Container(
                            child: Image.asset('assets/3.png'),
                            height: 250.0,
                            width: 250.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FadeTransition(
                      opacity: opacityAnimation,
                      child: Text(
                        'Welcome to FerryNav\nYour Online Ferry Booker',
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60.0), // Spacing between text and buttons
                FadeTransition(
                  opacity: opacityAnimation,
                  child: RoundedButton(
                    title: 'Log In',
                    colour: Color(0xFF219EBC),
                    onPressed: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                  ),
                ),
                FadeTransition(
                  opacity: opacityAnimation,
                  child: RoundedButton(
                    title: 'Register',
                    colour: Color(0xFF219EBC),
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
