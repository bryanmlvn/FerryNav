import 'package:ferrynav/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:ferrynav/screens/ticketdetails_page.dart';
import 'package:ferrynav/screens/ticketdetails_page.dart';

class PrivacypolicyPage extends StatelessWidget {
  static const String id = 'privacyPolicy_page';

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
                  width: 50.0,
                ),
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: containerColor, // Make sure containerColor is defined
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
                      'Privacy Policy \n',
                      style:h1Style
                  ),
                  Text(
                    '1. Introduction\n'
                        'Welcome to FerryNav! This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application to book ferry tickets and navigate ferry services. By using FerryNav, you agree to the collection and use of information in accordance with this policy.\n\n'
                        '2. Information We Collect\n'
                        'Personal Information: When you create an account or book a ferry, we may collect personal details such as your name, email address, phone number, and payment information.\n'
                        'Booking Information: We collect information related to your ferry bookings, including departure and arrival details, travel dates, and booking references.\n'
                        'Usage Data: We may collect information about how you interact with the app, such as IP addresses, device identifiers, app usage statistics, and crash reports.\n\n'
                        '3. How We Use Your Information\n'
                        'We use your information to:\n'
                        '• Process and manage ferry bookings.\n'
                        '• Communicate with you about your bookings and provide customer support.\n'
                        '• Improve and personalize your experience with our app.\n'
                        '• Send you updates, newsletters, and promotional offers (if you have opted in).\n'
                        '• Monitor and analyze app performance to enhance functionality and user experience.\n\n'
                        '4. How We Share Your Information\n'
                        'We may share your information with:\n'
                        '• Third-Party Service Providers: We may share information with vendors and service providers who assist us in operating the app and processing transactions (e.g., payment processors).\n'
                        '• Legal Requirements: We may disclose your information if required by law or to respond to legal processes, protect our rights, or comply with a court order.\n\n'
                        '5. Security\n'
                        'We implement reasonable security measures to protect your information from unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.\n\n'
                        '6. Your Choices\n'
                        '• Account Information: You can access, update, or delete your personal information by logging into your account or contacting our support team.\n'
                        '• Marketing Communications: You can opt out of receiving marketing communications by following the unsubscribe instructions in the emails or adjusting your notification settings within the app.\n\n'
                        '7. Children\'s Privacy\n'
                        'FerryNav is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected such information, we will take steps to delete it.\n\n'
                        '8. Changes to This Privacy Policy\n\n'
                        'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy on this page and updating the effective date. Your continued use of the app after any changes signifies your acceptance of the revised policy.',
                    style: TextStyle(fontSize: 16), // Optional: Adjust text style as needed
                  ),
                ],
              ),
            )

        ),
      ),
        );
  }
}
