import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ferrynav/screens/ticketdetails_page.dart';
import 'package:ferrynav/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String? _selectedDeparture;
  final List<String> _departure = [
    'Select Departure Port',
    'Batam',
    'Durai',
    'Hidayat Baru',
    'Kuala Gaung',
    'Moro',
    'Pelangairan',
    'Pulau Burung',
    'Sei Guntung',
    'Sembuang',
    'Sungai Piring',
    'Teluk Lanjut',
    'Tembilahan',
  ];

  String? _selectedArrival;
  final List<String> _arrival = [
    'Select Arrival Port',
    'Batam',
    'Durai',
    'Hidayat Baru',
    'Kuala Gaung',
    'Moro',
    'Pelangairan',
    'Pulau Burung',
    'Sei Guntung',
    'Sembuang',
    'Sungai Piring',
    'Teluk Lanjut',
    'Tembilahan',
  ];

  String? _selectedSeat;
  final List<String> _seat = ['Select Seat', '1', '2', '3', '4', '5'];

  DateTime? _selectedDate;

  late AnimationController _controller;
  late Animation<double> _animation;
  bool animationComplete = false;
  double buttonOpacity = 0.0;
  double containerOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Set the initial values
    _selectedDeparture = _departure[0];
    _selectedArrival = _arrival[0];
    _selectedSeat = _seat[0];

    // Initialize AnimationController
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now(); // Get the current date and time

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now, // Restrict the selection to today and future dates
      lastDate: DateTime(2101), // Set the last date to a distant future
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _search() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Check if the user is logged in
    if (user != null) {
      String email = user.email ?? '';

      // Collect selected data
      String departurePort = _selectedDeparture ?? '';
      String arrivalPort = _selectedArrival ?? '';
      String seatNumber = _selectedSeat ?? '';
      String departureDate = _selectedDate != null ? _selectedDate!.toLocal().toString().split(' ')[0] : '';

      // Update Firebase Database
      FirebaseFirestore.instance.collection('bookings').add({
        'email': email, // Add the user's email
        'departurePort': departurePort,
        'arrivalPort': arrivalPort,
        'numberOfPassanger': seatNumber,
        'departureDate': departureDate,
        'timestamp': FieldValue.serverTimestamp(), // For record keeping
      }).then((value) {
        print("Booking Added");
      }).catchError((error) {
        print("Failed to add booking: $error");
      });

      // Navigate to Ticket Details page after updating Firebase
      Navigator.pushNamed(context, TicketDetailsPage.id);
    } else {
      print("No user is logged in.");
      // Handle the case where no user is logged in (optional)
    }
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
                    Container(
                      margin: const EdgeInsets.only(
                          right: 8.0), // Space between image and title
                      child: Image.asset(
                        'assets/FerryNav-3.png',
                        width: 50.0,
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
            SizedBox(
              height: 15.0,
            ),
            AnimatedOpacity(
              opacity: containerOpacity,
              duration:
                  Duration(milliseconds: 500), // Set duration to 0.5 seconds
              child: Container(
                padding: EdgeInsets.all(16.0),
                margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                decoration: BoxDecoration(
                  color: appBarColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Book Ticket',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: containerColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 15.0), // Add some space between texts
                    Text(
                      '  From',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: containerColor,
                      ),
                    ),
                    SizedBox(
                        height:
                            5.0), // Add some space between Text and Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedDeparture,
                      onChanged: (String? newValue) {
                        if (newValue != _departure[0]) {
                          // Only update state if the new value is not the first item
                          setState(() {
                            _selectedDeparture = newValue;
                          });
                        }
                      },
                      items: _departure
                          .sublist(1)
                          .map<DropdownMenuItem<String>>((String location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(
                            location,
                            style: TextStyle(
                              color: appBarColor, // Text color
                            ),
                          ),
                        );
                      }).toList()
                        ..insert(
                            0,
                            DropdownMenuItem<String>(
                              value: _departure[0],
                              child: Text(
                                _departure[0], // Display the first item
                                style: TextStyle(
                                  color: Colors
                                      .grey, // Color for non-selectable item
                                ),
                              ),
                            )),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white, // Dropdown background color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: containerColor,
                              width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: containerColor,
                              width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: containerColor,
                              width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: appBarColor, // Icon color
                      ),
                      isExpanded: true, // Make the dropdown menu full width
                    ),

                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      '  To',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: containerColor,
                      ),
                    ),
                    SizedBox(
                        height:
                            5.0), // Add some space between Text and Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedArrival,
                      onChanged: (String? newValue) {
                        if (newValue != _arrival[0]) {
                          // Only update state if the new value is not the first item
                          setState(() {
                            _selectedArrival = newValue;
                          });
                        }
                      },
                      items: _arrival
                          .sublist(1)
                          .map<DropdownMenuItem<String>>((String location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(
                            location,
                            style: TextStyle(
                              color: appBarColor, // Text color
                            ),
                          ),
                        );
                      }).toList()
                        ..insert(
                            0,
                            DropdownMenuItem<String>(
                              value: _arrival[0],
                              child: Text(
                                _arrival[0], // Display the first item
                                style: TextStyle(
                                  color: Colors
                                      .grey, // Color for non-selectable item
                                ),
                              ),
                            )),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white, // Dropdown background color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: containerColor,
                              width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: containerColor,
                              width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: containerColor,
                              width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: appBarColor, // Icon color
                      ),
                      isExpanded: true, // Make the dropdown menu full width
                    ),

                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      '  Departure Date',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: containerColor,
                      ),
                    ),
                    SizedBox(
                        height:
                            5.0), // Add some space between Text and Dropdown
                    TextFormField(
                      readOnly: true, // Prevent user from manually editing date
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        hintText: _selectedDate != null
                            ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                            : 'Select Date', // Show the selected date or a placeholder
                        filled: true,
                        fillColor: Colors.white, // Background color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: containerColor,
                              width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: containerColor,
                              width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: containerColor,
                              width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: appBarColor, // Icon color
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      '  Number of Passanger',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: containerColor,
                      ),
                    ),
                    SizedBox(
                        height:
                            5.0), // Add some space between Text and Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedSeat,
                      onChanged: (String? newValue) {
                        if (newValue != _seat[0]) {
                          // Only update state if the new value is not the first item
                          setState(() {
                            _selectedSeat = newValue;
                          });
                        }
                      },
                      items: _seat
                          .sublist(1)
                          .map<DropdownMenuItem<String>>((String seat) {
                        return DropdownMenuItem<String>(
                          value: seat,
                          child: Text(
                            seat,
                            style: TextStyle(
                              color: appBarColor, // Text color
                            ),
                          ),
                        );
                      }).toList()
                        ..insert(
                            0,
                            DropdownMenuItem<String>(
                              value: _seat[0],
                              child: Text(
                                _seat[0], // Display the first item
                                style: TextStyle(
                                  color: Colors
                                      .grey, // Color for non-selectable item
                                ),
                              ),
                            )),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white, // Dropdown background color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: containerColor,
                              width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: containerColor,
                              width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: containerColor,
                              width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: appBarColor, // Icon color
                      ),
                      isExpanded: true, // Make the dropdown menu full width
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    AnimatedOpacity(
                      opacity: buttonOpacity,
                      duration: Duration(
                          milliseconds: 500), // Set duration to 0.5 seconds
                      child: RoundedButton(
                        title: 'Search',
                        colour: Color(0xFF219EBC),
                        onPressed: _search,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedOpacity(
        opacity: containerOpacity,
        duration: Duration(milliseconds: 500),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), // Adjust the radius as needed
            topRight: Radius.circular(20.0), // Adjust the radius as needed
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor:
                  appBarColor, // Background color of the navigation bar
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
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
