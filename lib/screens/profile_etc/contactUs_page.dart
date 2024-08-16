import 'package:flutter/material.dart';
import 'package:ferrynav/screens/ticketdetails_page.dart';
import 'package:ferrynav/styles/style.dart';

class ContactusPage extends StatelessWidget {
  static const String id = 'contactUs_page';

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
                  width: 60.0,
                ),
                Text(
                  'Contact Us',
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
      body:  Container(
          margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0), // Adjust padding as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Us\n',
                  style: h1Style,
                ),
                Text(
                  'We are here to help you with any questions or concerns you may have. Please feel free to reach out to us through the following channels:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.email, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Email: support@ferrynav.com',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.phone, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Phone: +123 456 7890',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Address: 123 FerryNav Street, Port City, Country',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                Text(
                  'Follow Us',
                  style: TextStyle(
                    fontSize: 20, // Subtitle font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.language, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Website: www.ferrynav.com',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.facebook, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Facebook: facebook.com/ferrynav',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.close, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Twitter: twitter.com/ferrynav',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }
}
