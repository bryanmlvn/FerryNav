import 'package:ferrynav/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:ferrynav/components/rounded_button.dart';
import 'package:ferrynav/auth.dart';
import 'package:ferrynav/user_firestore.dart';

class RegisterPage extends StatefulWidget {
  static const String id = 'register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  String _errorMessage = '';

  late AnimationController _controller;
  late Animation _animation;
  bool animationComplete = false;
  double buttonOpacity = 0.0;

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

  final Auth _auth = Auth();
  final FirestoreService _firestoreService = FirestoreService();

  void _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'All fields are required';
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await _firestoreService.addUserDetails(
        uid: _auth.currentUser!.uid,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );

      setState(() {
        _isLoading = false;
        _errorMessage = 'Registration successful!';
        Navigator.pushNamed(context, LoginPage.id);
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildTextField(
      {required TextEditingController controller,
      required String hintText,
      bool obscureText = false,
      bool passwordVisible = false,
      VoidCallback? togglePasswordVisibility}) {
    return AnimatedOpacity(
      opacity: animationComplete ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: TextField(
        controller: controller,
        obscureText: obscureText && !passwordVisible,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF06305A), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF06305A), width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          suffixIcon: togglePasswordVisibility != null
              ? IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: togglePasswordVisibility,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD2FBF7),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedOpacity(
            opacity: animationComplete ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
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
                const Text(
                  'Fill your data below',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
                Column(
                  children: <Widget>[
                    buildTextField(
                      controller: _nameController,
                      hintText: 'Enter your name',
                    ),
                    const SizedBox(height: 8.0),
                    buildTextField(
                      controller: _emailController,
                      hintText: 'Enter your email',
                      obscureText: false,
                    ),
                    const SizedBox(height: 8.0),
                    buildTextField(
                      controller: _phoneController,
                      hintText: 'Enter your phone number',
                      obscureText: false,
                    ),
                    const SizedBox(height: 8.0),
                    buildTextField(
                      controller: _passwordController,
                      hintText: 'Enter your password',
                      obscureText: true,
                      passwordVisible: _passwordVisible,
                      togglePasswordVisibility: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    const SizedBox(height: 8.0),
                    buildTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm your password',
                      obscureText: true,
                      passwordVisible: _confirmPasswordVisible,
                      togglePasswordVisibility: () {
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                AnimatedOpacity(
                  opacity: animationComplete ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                AnimatedOpacity(
                  opacity: animationComplete ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    width: double.infinity,
                    child: RoundedButton(
                      title: 'Register',
                      colour: Color(0xFF219EBC),
                      onPressed: _register,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
