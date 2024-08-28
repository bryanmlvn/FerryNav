import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ferrynav/screens/ticketdetails_page.dart';
import 'package:ferrynav/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ferrynav/screens/profile_page.dart';
import 'package:ferrynav/styles/style.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //DIBAWAH FUNCTION PASSING VALUE
  void navigateToDetails(BuildContext ctx) {
    String getFormattedDate(DateTime? date) {
      if (date == null) return 'Select Date';
      final DateFormat formatter = DateFormat('EEEE, dd MMM yyyy');
      return formatter.format(date);
    }

    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return TicketDetailsPage(
        cityFrom: _selectedDeparture,
        cityDestination: _selectedArrival,
        numberOfPassenger: _selectedSeat,
        date: getFormattedDate(_selectedDate),
      );
    }));
  }
  //DIATAS FUNCTION PASSING VALUE

  String? _selectedDeparture;
  final List<String> _departure = [
    'Batam',
    'Moro',
    'Durai',
    'Sei Guntung',
    'Pulau Burung',
    'Tembilahan',
  ];

  String? _selectedArrival;
  final List<String> _arrival = [
    'Batam',
    'Moro',
    'Durai',
    'Sei Guntung',
    'Pulau Burung',
    'Tembilahan',
  ];

  String? _selectedSeat;
  final List<String> _seat = ['1', '2', '3', '4', '5'];

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
    _selectedDeparture = null;
    _selectedArrival = null;
    _selectedSeat = null;

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

  void _search() {
    if (_selectedDeparture == null || _selectedArrival == null || _selectedSeat == null || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incomplete Information'),
            content: Text('Please select all options and a date to proceed.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    navigateToDetails(context);
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
              duration:
              Duration(milliseconds: 500), // Set duration to 0.5 seconds
              child: Container(
                padding: EdgeInsets.all(16.0),
                margin: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
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
                      hint: Text('Select Departure Port'),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedDeparture = newValue;
                          });
                        }
                      },
                      items: _departure.map<DropdownMenuItem<String>>((String location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(
                            location,
                            style: TextStyle(
                              color: appBarColor, // Text color
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white, // Dropdown background color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: containerColor,
                            width: 3.0, // Border color and width
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: containerColor,
                            width: 3.0, // Border color and width
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: containerColor,
                            width: 3.0, // Border color and width
                          ),
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
                      hint: Text('Select Arrival Port'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedArrival = newValue;
                        });
                      },
                      items: _arrival.map<DropdownMenuItem<String>>((String location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(
                            location,
                            style: TextStyle(
                              color: appBarColor, // Text color
                            ),
                          ),
                        );
                      }).toList(),
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
                      value: _selectedSeat, // Set the selected value or null if none is selected
                      hint: Text('Number of Passengers'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSeat = newValue; // Update the selected seat when changed
                        });
                      },
                      items: _seat.map<DropdownMenuItem<String>>((String seat) {
                        return DropdownMenuItem<String>(
                          value: seat,
                          child: Text(
                            seat,
                            style: TextStyle(
                              color: appBarColor, // Text color
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white, // Dropdown background color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: containerColor,
                            width: 3.0, // Border color and width
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: containerColor,
                            width: 3.0, // Border color and width
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: containerColor,
                            width: 3.0, // Border color and width
                          ),
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
                      duration: Duration(milliseconds: 500), // Set duration to 0.5 seconds
                      child: RoundedButton(
                        title: 'Search',
                        colour: Color(0xFF219EBC),
                        onPressed: () {
                          _search(); // Call the _search method with parentheses
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}