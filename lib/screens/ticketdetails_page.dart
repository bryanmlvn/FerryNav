import 'package:ferrynav/screens/seat_page.dart';
import 'package:flutter/material.dart';
// import 'package:ferrynav/components/rounded_button.dart';
import 'package:ferrynav/styles/style.dart';
import 'package:intl/intl.dart'; //untuk perhitungan

// String cityFrom = "City 1";
String pelabuhanFrom = "Pelabuhan 1";
String timeFrom = '10.30';
// String cityDestination = "City 2";
String pelabuhanDestination = "Pelabuhan 2";
String timeDestination = '15.30';
// String date = "Fri, 99 December 2099";
int remainingSeat = 999;
String duration = "±5h 15m";
String kodeFerry = "FerryNav 02";
int seatCapacity = 200;

//REFACTORING (EXTRACT METHOD OR WIDGET)

//CODE HERE BROTHAA
class TicketDetailsPage extends StatefulWidget {
  const TicketDetailsPage(
      {Key? key,
      this.cityFrom,
      this.cityDestination,
      this.date,
      this.numberOfPassenger})
      : super(key: key);
  static const String id = 'ticketdetails_page';
  final String? cityFrom;
  final String? cityDestination;
  final String? date;
  final String? numberOfPassenger;

  @override
  State<TicketDetailsPage> createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends State<TicketDetailsPage> {
  void navigateToSeatPage(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return SeatPage(
        cityFrom: widget.cityFrom,
        cityDestination: widget.cityDestination,
        date: widget.date,
        numberOfPassenger: widget.numberOfPassenger,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    // perhitungan harga
    final formattedPrice = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(int.parse(widget.numberOfPassenger ?? '0') * 525000);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Ticket Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
                decoration: commonBoxDecorationStyle(containerColor),
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${widget.cityFrom} - ${widget.cityDestination}',
                        style: h1Style,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${widget.date}",
                            style: h3Style,
                          ),
                          Text(
                            duration,
                            style: h3Style,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${widget.numberOfPassenger} seat',
                            style: h3Style,
                          ),
                          Text(
                            '$remainingSeat Remaining seats',
                            style: h3Style,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                decoration: commonBoxDecorationStyle(appBarColor),
                constraints: const BoxConstraints(
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
                              "${widget.cityFrom}",
                              style: h2Style,
                            ),
                            Text(
                              '$pelabuhanFrom\n$timeFrom',
                              style: desc1Style(Colors.white),
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
                              "${widget.cityDestination}",
                              style: h2Style,
                            ),
                            Text(
                              '$pelabuhanDestination\n$timeDestination',
                              textAlign: TextAlign.end,
                              style: desc1Style(Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                      decoration: commonBoxDecorationStyle(containerColor),
                      constraints: const BoxConstraints(
                        minWidth: double.infinity,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            kodeFerry,
                            style: h3Style,
                          ),
                          const Divider(
                            color: Colors
                                .black, // You can customize the color of the divider
                            thickness:
                                1, // You can customize the thickness of the divider
                            height:
                                20, // You can customize the space between the text and the divider
                          ),
                          Text(
                            'Ferry Specifications',
                            style: desc1Style(Colors.black),
                          ),
                          const SizedBox(height: 3.0),
                          Text(
                            'Seat Capacity : $seatCapacity\nSeat Format : 1 seat/person',
                            style: h4Style,
                          ),
                          const Divider(
                            color: Colors
                                .black, // You can customize the color of the divider
                            thickness:
                                1, // You can customize the thickness of the divider
                            height:
                                20, // You can customize the space between the text and the divider
                          ),
                          Text(
                            'Facilities',
                            style: desc1Style(Colors.black),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Row(
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0.0), // Margin from the body
        child: Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: const BorderRadius.only(
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
                padding: EdgeInsets.fromLTRB(
                    20, 0, 20, 10), // Adjust padding as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Center the Column's children vertically
                  children: <Widget>[
                    Text(
                      'Total Price',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black, // Adjust as needed
                      ),
                    ),
                    Text(
                      formattedPrice,
                      style: const TextStyle(
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
                    navigateToSeatPage(context);
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
                        const Size(150, 40), // Set minimum size for the button
                  ),
                  child: const Text(
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

// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Text(
// '${widget.cityFrom}',
// style: h1Style,
// textAlign: TextAlign.left,
// ),
// Text(
// '-',
// style: h1Style,
// textAlign: TextAlign.left,
// ),
// Text(
// '${widget.cityDestination}',
// style: h1Style,
// textAlign: TextAlign.left,
// ),
// ],
// ),
