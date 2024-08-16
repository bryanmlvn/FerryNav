import 'package:ferrynav/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:ferrynav/screens/ticketdetails_page.dart';
import 'package:ferrynav/screens/ticketdetails_page.dart';

class TermconditionPage extends StatelessWidget {
  static const String id = 'termCondition_page';

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
                  width: 40.0,
                ),
                Text(
                  'Term & Condition',
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
                        'Term & Condition \n',
                        style: h1Style
                    ),
                    Text(
                          '1. Introduction\n'
                          'Welcome to FerryNav! These Terms and Conditions ("Terms") govern your use of our mobile application ("App") for booking ferry tickets and navigating ferry services. By using FerryNav, you agree to these Terms. If you do not agree, please do not use our App.\n\n'
                          '2. Use of the App\n'
                          '• Eligibility: You must be at least 18 years old or have the consent of a parent or guardian to use our App.\n'
                          '• Account Responsibility: You are responsible for maintaining the confidentiality of your account information and for all activities under your account.\n\n'
                          '3. Booking and Payments\n'
                          '• Booking: All bookings made through FerryNav are subject to availability and confirmation. We reserve the right to refuse or cancel any booking.\n'
                          '• Payment: Payment must be completed at the time of booking. We use third-party payment processors to handle transactions, and your payment information will be processed securely.\n\n'
                          '4. Content and Intellectual Property\n'
                          '• Ownership: All content on the App, including text, images, and logos, is the property of FerryNav or our licensors and is protected by intellectual property laws.\n'
                          '• Usage: You may use the content solely for personal, non-commercial purposes. Unauthorized use or reproduction of the content is prohibited.\n\n'
                          '5. User Conduct\n'
                          '• Prohibited Activities: You agree not to engage in any activities that are illegal, harmful, or disruptive to the App or its users.\n'
                          '• Reporting: If you encounter any issues or inappropriate content, please report it to us at [support@ferrynav.com].\n\n'
                          '6. Limitation of Liability\n'
                          '• Disclaimer: FerryNav provides the App on an "as is" basis and makes no warranties or representations about the accuracy, reliability, or availability of the App.\n'
                          '• Liability: To the maximum extent permitted by law, FerryNav is not liable for any indirect, incidental, or consequential damages arising from your use of the App.\n\n'
                          '7. Termination\n'
                          'We reserve the right to suspend or terminate your access to the App if you violate these Terms or engage in activities that harm the App or other users.\n\n'
                          '8. Changes to Terms\n'
                          'We may update these Terms from time to time. We will notify you of any changes by posting the updated Terms on this page. Your continued use of the App after changes are made constitutes your acceptance of the revised Terms.\n\n'
                          '9. Governing Law\n'
                          'These Terms are governed by and construed in accordance with the laws of [Insert Jurisdiction], without regard to its conflict of law principles.\n\n',
                      style: TextStyle(fontSize: 16), // Optional: Adjust text style as needed
                    ),
                  ],
                ),
              ),
            )
      ),
      );
  }
}
