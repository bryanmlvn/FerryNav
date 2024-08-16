import 'package:ferrynav/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:ferrynav/screens/ticketdetails_page.dart';

class AboutusPage extends StatelessWidget {
  static const String id = 'aboutUs_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: appBarColor,
          iconTheme: IconThemeData(
            color: containerColor,
          ),
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 70.0,
                ),
                Text(
                  'About Us',
                  style: TextStyle(
                    color:
                        containerColor, // Make sure containerColor is defined
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0), // Adjust padding as needed
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Us\n',
                    style: h1Style
                  ),
                  Text(
                    'Welcome to FerryNav! We are dedicated to providing a seamless and convenient experience for booking ferry tickets and navigating ferry services.\n\n'
                        'Founded in [Year], our mission is to make ferry travel easy and accessible for everyone. With our user-friendly mobile application, you can easily search for ferry routes, book tickets, and receive real-time updates about your travel.\n\n'
                        'Our team is committed to customer satisfaction and continuous improvement. We work closely with ferry operators to ensure that our app offers accurate and up-to-date information.\n\n'
                        'If you have any questions or feedback, please feel free to reach out to us at [support@ferrynav.com].\n\n'
                        'Thank you for choosing FerryNav. We look forward to serving you!\n\n'
                        'Sincerely,\n'
                        'The FerryNav Team',
                    style: TextStyle(
                      fontSize: 16, // Body text font size
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
