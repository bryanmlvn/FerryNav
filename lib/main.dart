import 'package:ferrynav/screens/home_page.dart';
import 'package:ferrynav/screens/profile_page.dart';
import 'package:ferrynav/screens/seat_page.dart';
import 'package:ferrynav/screens/ticketdetails_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ferrynav/screens/splash_page.dart';
import 'package:ferrynav/screens/welcome_page.dart';
import 'package:ferrynav/screens/login_page.dart';
import 'package:ferrynav/screens/register_page.dart';
import 'package:ferrynav/navigation_menu.dart';
import 'package:ferrynav/screens/history_page.dart';
import 'package:ferrynav/screens/profile_etc/privacyPolicy_page.dart';
import 'package:ferrynav/screens/profile_etc/aboutUs_page.dart';
import 'package:ferrynav/screens/profile_etc/contactUs_page.dart';
import 'package:ferrynav/screens/profile_etc/termCondition_page.dart';
import 'package:ferrynav/screens/profile_etc/faq_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FerryNavApp());
}

class FerryNavApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        HomePage.id: (context) => HomePage(),
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        TicketDetailsPage.id: (context) => TicketDetailsPage(),
        SeatPage.id: (context) => SeatPage(),
        ProfilePage.id: (context) => ProfilePage(),
        NavigationMenu.id: (context) => NavigationMenu(),
        HistoryPage.id: (context) => HistoryPage(),
        PrivacypolicyPage.id: (context) => PrivacypolicyPage(),
        TermconditionPage.id: (context) => TermconditionPage(),
        FaqPage.id: (context) => FaqPage(),
        ContactusPage.id: (context) => ContactusPage(),
        AboutusPage.id: (context) => AboutusPage(),
      },
    );
  }
}
