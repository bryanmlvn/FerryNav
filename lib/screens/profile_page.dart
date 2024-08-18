import 'package:ferrynav/screens/profile_etc/editProfile_page.dart';
import 'package:ferrynav/user_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ferrynav/styles/style.dart';
import 'package:ferrynav/screens/profile_etc/aboutUs_page.dart';
import 'package:ferrynav/screens/profile_etc/contactUs_page.dart';
import 'package:ferrynav/screens/profile_etc/faq_page.dart';
import 'package:ferrynav/screens/profile_etc/privacyPolicy_page.dart';
import 'package:ferrynav/screens/profile_etc/termCondition_page.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile_page';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  String? userName;
  String? userMail;

  late AnimationController _controller;
  late Animation<double> _animation;
  bool animationComplete = false;
  double buttonOpacity = 0.0;
  double containerOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserDetails(); // Properly calling the function

    _controller = AnimationController(
      duration: Duration(milliseconds: 350), // Set duration to 0.35 seconds
      vsync: this,
    );

    // Define the animation
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // Start the animation after a delay
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        buttonOpacity = 1.0;
        containerOpacity = 1.0;
      });
      _controller.forward();
    });
  }

  Future<void> _loadCurrentUserDetails() async {
    FirestoreService firestoreService = FirestoreService();
    String? name = await firestoreService.getCurrentUserName();
    String? email = await firestoreService.getCurrentUserEmail(); // Assuming you meant to get the email here
    setState(() {
      userName = name;
      userMail = email; // Corrected the variable name
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return AppBar(
              automaticallyImplyLeading: false,
              title: Center(
                child: Row(
                  mainAxisSize:
                  MainAxisSize.min, // Make the row as small as its children
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: _animation
                          .value, // Apply the animation value to opacity
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 8.0), // Space between image and title
                        child: Image.asset(
                          'assets/FerryNav-3.png',
                          width: 50.0,
                        ),
                      ),
                    ),
                    Text(
                      'FerryNav',
                      style: TextStyle(
                        color: containerColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: appBarColor.withOpacity(_animation.value),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            AnimatedOpacity(
              opacity: containerOpacity,
              duration: Duration(milliseconds: 500),
              child: Container(
                padding: EdgeInsets.all(16.0),
                margin: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                decoration: BoxDecoration(
                  color: appBarColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userName ?? ' ', // Displaying the actual name
                      style: h2Style,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          userMail ?? ' ', // Displaying the actual email
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -13), // Adjust the vertical offset (x, y). Negative y moves the icon up
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditprofilePage()));
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Repeated containers with different titles and onTap methods
            buildMenuItem(
              context,
              title: 'Term & Condition',
              icon: Icons.description,
              page: TermconditionPage(),
            ),
            buildMenuItem(
              context,
              title: 'About Us',
              icon: Icons.apartment,
              page: AboutusPage(),
            ),
            buildMenuItem(
              context,
              title: 'Privacy Policy',
              icon: Icons.privacy_tip,
              page: PrivacypolicyPage(),
            ),
            buildMenuItem(
              context,
              title: 'FAQ',
              icon: Icons.question_mark,
              page: FaqPage(),
            ),
            buildMenuItem(
              context,
              title: 'Contact Us',
              icon: Icons.call,
              page: ContactusPage(),
            ),
          ],
        ),
      ),
    );
  }

  //Build Menu Item Function
  Widget buildMenuItem(BuildContext context,
      {required String title, required IconData icon, required Widget page}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      borderRadius: BorderRadius.circular(16.0),
      child: AnimatedOpacity(
        opacity: containerOpacity,
        duration: Duration(milliseconds: 500),
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
          decoration: BoxDecoration(
            color: appBarColor,
            borderRadius: BorderRadius.circular(16.0),
          ),
          constraints: BoxConstraints(
            minWidth: double.infinity,
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 18.0),
              Text(
                title,
                style: h2Style,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
