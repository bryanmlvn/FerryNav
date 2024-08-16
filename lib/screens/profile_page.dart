import 'package:flutter/material.dart';
import 'package:ferrynav/screens/ticketdetails_page.dart';
import 'package:ferrynav/styles/style.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile_page';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool animationComplete = false;
  double buttonOpacity = 0.0;
  double containerOpacity = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          children: <Widget>[Text('Profile Page')],
        ),
      ),
    );
  }
}
