import 'package:flutter/material.dart';
import 'package:ferrynav/components/rounded_button.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'login_page'; // Add this

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Image.asset(
                'assets/FerryNav.png',
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Welcome to FerryNav\nYour only Ferry Booker',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50.0,
            ),
            Column(
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    // Do something with the user input.
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    // Do something with the user input.
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 70.0,
            ),
            Container(
              width: double.infinity,
              child: RoundedButton(
                title: 'Log in',
                colour: Colors.lightBlueAccent,
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
