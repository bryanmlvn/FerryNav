import 'package:ferrynav/screens/home_page.dart';
import 'package:ferrynav/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:ferrynav/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ferrynav/auth.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Auth _auth = Auth();

  String? errorMessage;

  late AnimationController _controller;
  late Animation _animation;
  bool animationComplete = false;
  double buttonOpacity = 0.0;

  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 350), // Set duration to 0.5 seconds
      vsync: this,
    );

    _animation = ColorTween(begin: Colors.blueGrey, end: Color(0xFFE1F7F5))
        .animate(_controller);

    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          animationComplete = true;
          buttonOpacity = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print("Login successful");
      Navigator.pushNamed(context, NavigationMenu.id);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      print("Login failed: $errorMessage");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD2FBF7),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0),
              Hero(
                tag: 'logo',
                child: ClipOval(
                  child: AnimatedOpacity(
                    opacity: animationComplete ? 1.0 : 0.0,
                    duration: Duration(
                        milliseconds: 500), // Set duration to 0.5 seconds
                    child: Image.asset(
                      'assets/3.png',
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              AnimatedOpacity(
                opacity: animationComplete ? 1.0 : 0.0,
                duration:
                    Duration(milliseconds: 500), // Set duration to 0.5 seconds
                child: const Text(
                  'Welcome to FerryNav\nYour only Ferry Booker',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 60.0),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10.0),
              Column(
                children: <Widget>[
                  AnimatedOpacity(
                    opacity: animationComplete ? 1.0 : 0.0,
                    duration: Duration(
                        milliseconds: 500), // Set duration to 0.5 seconds
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF06305A), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF06305A), width: 3.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  AnimatedOpacity(
                    opacity: animationComplete ? 1.0 : 0.0,
                    duration: Duration(
                        milliseconds: 500), // Set duration to 0.5 seconds
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF06305A), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF06305A), width: 3.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70.0),
              // AnimatedOpacity(
              //   opacity: buttonOpacity,
              //   duration:
              //       Duration(milliseconds: 500), // Set duration to 0.5 seconds
              //   child: Container(
              //     width: double.infinity,
              //     child: RoundedButton(
              //       title: 'Log in',
              //       colour: Color(0xFF219EBC),
              //       onPressed: _login,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AnimatedOpacity(
        opacity: buttonOpacity,
        duration: Duration(milliseconds: 500), // Set duration to 0.5 seconds
        child: Container(
          margin: EdgeInsets.only(bottom: 60, left: 20, right: 20),
          width: double.infinity,
          child: RoundedButton(
            title: 'Log in',
            colour: Color(0xFF219EBC),
            onPressed: _login,
          ),
        ),
      ),
    );
  }
}
