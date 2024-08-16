import 'package:flutter/material.dart';
import 'package:ferrynav/screens/ticketdetails_page.dart';
import 'package:ferrynav/styles/style.dart';

class FaqPage extends StatelessWidget {
  static const String id = 'faq_page';

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
                  width: 100.0,
                ),
                Text(
                  'FAQ',
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
                  'Frequently Asked Questions\n',
                  style: h1Style
                ),
                ExpansionTile(
                  title: Text(
                    '1. How do I book a ferry ticket?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'To book a ferry ticket, simply open the FerryNav app, search for your desired route, select your travel dates, and follow the prompts to complete your booking. You can pay securely through our integrated payment gateway.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    '2. Can I cancel or modify my booking?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Yes, you can cancel or modify your booking through the app. Go to "My Bookings," select the booking you want to change, and follow the instructions. Please note that cancellation fees may apply depending on the ferry operator’s policy.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    '3. What payment methods are accepted?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'We accept various payment methods, including credit/debit cards and digital wallets. All transactions are processed securely through our payment partners.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    '4. How can I contact customer support?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'You can reach our customer support team by emailing [support@ferrynav.com] or calling our support hotline at [Insert Contact Number]. We’re here to help with any questions or issues you may have.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    '5. Is my personal information safe?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Yes, we take your privacy seriously. We implement industry-standard security measures to protect your personal information. For more details, please read our Privacy Policy.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )

        ),
      );
  }
}
