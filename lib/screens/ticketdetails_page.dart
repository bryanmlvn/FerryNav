import 'package:flutter/material.dart';
// import 'package:ferrynav/components/rounded_button.dart';

Color appBarColor = const Color(0xFF06305A);
Color containerColor = const Color(0xFFd2fbf7);
String cityFrom = "City 1";
String pelabuhanFrom = "Pelabuhan 1";
String timeFrom = '10.30';
String cityDestination = "City 2";
String pelabuhanDestination = "Pelabuhan 2";
String timeDestination = '15.30';
String date = "Fri, 99 December 2099";
int remainingSeat = 999;
String duration = "±5h 15m";
String kodeFerry = "FerryNav 02";
int seatCapacity = 200;

class TicketDetails extends StatefulWidget {
  static const String id = 'ticketdetails_page';

  @override
  State<TicketDetails> createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Ticket Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appBarColor,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              constraints: BoxConstraints(
                minWidth: double.infinity,
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$cityFrom - $cityDestination',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          duration,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '$remainingSeat Remaining seats',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
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
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            cityFrom,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '$pelabuhanFrom\n$timeFrom',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "->",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '$cityDestination',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '$pelabuhanDestination\n$timeDestination',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          kodeFerry,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Divider(
                          color: Colors
                              .black, // You can customize the color of the divider
                          thickness:
                              1, // You can customize the thickness of the divider
                          height:
                              20, // You can customize the space between the text and the divider
                        ),
                        Text(
                          'Ferry Specifications',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          'Seat Capacity : $seatCapacity\nSeat Format : 1 seat/person',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          color: Colors
                              .black, // You can customize the color of the divider
                          thickness:
                              1, // You can customize the thickness of the divider
                          height:
                              20, // You can customize the space between the text and the divider
                        ),
                        Text(
                          'Facilities',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Icon(
                                  Icons
                                      .wc, // Example toilet icon, you can use any suitable icon
                                  size: 24.0,
                                  color: Colors.black,
                                ),
                                Text(
                                  'Toilet',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              children: <Widget>[
                                Icon(
                                  Icons
                                      .local_drink, // Example free drink icon, you can use any suitable icon
                                  size: 24.0,
                                  color: Colors.black,
                                ),
                                Text(
                                  'Free Drink',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0.0), // Margin from the body
        child: Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), // Adjust radius as needed
              topRight: Radius.circular(20.0), // Adjust radius as needed
            ),
          ),
          height: MediaQuery.of(context).size.height *
              0.165, // Adjust height as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment
                .center, // Center the Row's children vertically
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    20, 0, 20, 10), // Adjust padding as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Center the Column's children vertically
                  children: <Widget>[
                    Text(
                      'Price/Seat',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black, // Adjust as needed
                      ),
                    ),
                    Text(
                      'Rp. 525.000',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0), // Horizontal padding for button
                child: ElevatedButton(
                  onPressed: () {
                    // Handle the continue button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        appBarColor, // Button color (formerly primary)
                    foregroundColor:
                        containerColor, // Text color (formerly onPrimary)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    minimumSize:
                        Size(150, 40), // Set minimum size for the button
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}