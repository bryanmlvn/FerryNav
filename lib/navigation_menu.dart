import 'package:ferrynav/screens/history_page.dart';
import 'package:ferrynav/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:ferrynav/screens/home_page.dart';
import 'package:ferrynav/screens/ticketdetails_page.dart';
import 'package:ferrynav/styles/style.dart';

class NavigationMenu extends StatefulWidget {
  static const String id = 'navigation_menu';

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late AnimationController _controller;
  double containerOpacity = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        containerOpacity = 1.0;
      });
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedOpacity(
        opacity: containerOpacity,
        duration: Duration(milliseconds: 500),
        child: Container(
          decoration: BoxDecoration(
            color: appBarColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), // Adjust the radius as needed
              topRight: Radius.circular(20.0), // Adjust the radius as needed
            ),
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor:
                  Colors.transparent, // Set to transparent for rounded corners
              indicatorColor:
                  containerColor, // Indicator color for selected item
              iconTheme: MaterialStateProperty.resolveWith<IconThemeData>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return IconThemeData(
                      color: appBarColor); // Color when the icon is selected
                }
                return IconThemeData(
                    color:
                        containerColor); // Color when the icon is not selected
              }),
              labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return TextStyle(
                      color: containerColor); // Label color when selected
                }
                return TextStyle(
                    color: containerColor); // Label color when not selected
              }),
            ),
            child: NavigationBar(
              height: 80.0,
              elevation: 0.0,
              backgroundColor: Colors.transparent, // Set to transparent
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.history), label: 'History'),
                NavigationDestination(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          ),
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}
