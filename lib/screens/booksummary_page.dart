import 'package:flutter/material.dart';
import 'package:ferrynav/repository/user_firestore.dart';
import 'package:ferrynav/styles/style.dart';
import 'package:ferrynav/business_logic/logic.dart';
import 'package:unofficial_midtrans_sdk/unofficial_midtrans_sdk.dart';
import 'package:uuid/uuid.dart';
import 'package:ferrynav/screens/webview_page.dart';
import 'package:ferrynav/repository/booking_firestore.dart' as booking;
import 'package:ferrynav/repository/user_firestore.dart' as user;
//tes

String timeFrom = '10.30';
String timeDestination = '15.30';
String duration = "±5h 15m";

class BookSummaryPage extends StatefulWidget {
  static const String id = 'booksummary_page';
  const BookSummaryPage({
    Key? key,
    this.cityFrom,
    this.cityDestination,
    this.date,
    this.numberOfPassenger,
    this.selectedSeats,
  }) : super(key: key);
  final String? cityFrom;
  final String? cityDestination;
  final String? date;
  final String? numberOfPassenger;
  final List<int>? selectedSeats;

  @override
  BookSummaryPageState createState() => BookSummaryPageState();
}

class BookSummaryPageState extends State<BookSummaryPage> {
  void navigateToWebView(BuildContext ctx, String redirectUrl, String orderId) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return WebviewPage(
        cityFrom: widget.cityFrom,
        cityDestination: widget.cityDestination,
        date: widget.date,
        numberOfPassenger: widget.numberOfPassenger,
        selectedSeats: widget.selectedSeats,
        redirectUrl: redirectUrl,
        orderId: orderId, // Now orderId is passed correctly
      );
    }));
  }

  final user.FirestoreService _userService =
      user.FirestoreService(); // Instance for user functions

  void _bookingPending() async {
    String? uid = await _userService.getCurrentUserUID();
    if (uid != null) {
      await booking.FirestoreService().addNewBookings(
        uid: uid,
        selectedSeats: widget.selectedSeats ?? [],
        date: widget.date ?? "",
        status: 'pending',
        from: widget.cityFrom ?? "",
        destination: widget.cityDestination ?? "",
      );
    }
  }

  final midtrans = MidtransSDK(
    apikey: 'SB-Mid-server-KEXEZM6ynCF5Ru5tLg6pBuzA',
    isProduction: false,
  );

  String? userName;
  String? userPhone;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserDetails();
  }

  String formatSeatNumbers(List<int>? seats) {
    if (seats == null || seats.isEmpty) {
      return 'No seats selected';
    } else if (seats.length == 1) {
      return 'Seat Number ${seats[0]}';
    } else if (seats.length == 2) {
      return 'Seat Number ${seats[0]} and ${seats[1]}';
    } else {
      String formattedSeats = 'Seat Number ${seats[0]}';
      for (int i = 1; i < seats.length - 1; i++) {
        formattedSeats += ', ${seats[i]}';
      }
      formattedSeats += ', and ${seats[seats.length - 1]}';
      return formattedSeats;
    }
  }

  Future<void> _loadCurrentUserDetails() async {
    FirestoreService firestoreService = FirestoreService();
    String? name = await firestoreService.getCurrentUserName();
    String? phone = await firestoreService.getCurrentUserPhone();
    setState(() {
      userName = name;
      userPhone = phone;
      isLoading = false;
    });
  }

  //makePayment
  void makePayment(MidtransSDK midtrans, String cityFrom,
      String cityDestination, int numberOfPassenger) async {
    var uuid = Uuid();
    String orderId = uuid.v4(); // Generate a unique order ID

    // Use the new method to get the total price as an integer
    int totalPrice = calculateTotalPriceInt(cityFrom, cityDestination, numberOfPassenger);

    final response = await midtrans.pay({
      'transaction_details': {
        'order_id': orderId,
        'gross_amount': totalPrice, // Pass the integer value for total price
      },
    });

    if (response['redirect_url'] != null) {
      final redirectUrl = response['redirect_url'];
      print('Redirect to: $redirectUrl');

      // Pass the orderId when calling navigateToWebView
      navigateToWebView(context, redirectUrl, orderId);
    }
  }


  @override
  Widget build(BuildContext context) {
    final cityFrom = widget.cityFrom ?? '';
    final cityDestination = widget.cityDestination ?? '';
    final numberOfPassenger =
        int.tryParse(widget.numberOfPassenger ?? '0') ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: containerColor,
        ),
        title: const Text(
          "Book Summary",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appBarColor,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
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
                              "Payment Information",
                              style: h2Style.copyWith(color: Color(0xFF06305A)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              userName ?? 'Loading...',
                              style: desc1Style(Colors.black),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              userPhone ?? 'Loading...',
                              style: desc1Style(Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      decoration: commonBoxDecorationStyle(containerColor),
                      constraints: const BoxConstraints(
                        minWidth: double.infinity,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Ferry Schedule",
                              style: h2Style.copyWith(color: Color(0xFF06305A)),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: <Widget>[
                                // City From on the left
                                Text(
                                  "${widget.cityFrom}",
                                  style: h4Style,
                                ),

                                // Time From
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    timeFrom,
                                    style: desc1Style(Colors.black),
                                  ),
                                ),

                                // Expanded to fill space and align custom arrow icon and duration in the center
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      // Line representing the arrow's length
                                      Expanded(
                                        child: Container(
                                          height: 2.0, // Thickness of the line
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Arrow Icon
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          size: 20.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 2.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    timeDestination,
                                    style: desc1Style(Colors.black),
                                  ),
                                ),
                                Text(
                                  "${widget.cityDestination}",
                                  style: h4Style,
                                ),
                              ],
                            ),
                            Text(
                              formatSeatNumbers(widget.selectedSeats),
                              style: desc1Style(Colors.black),
                            ),
                            Text(
                              '${widget.date}',
                              style: desc1Style(Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      decoration: commonBoxDecorationStyle(containerColor),
                      constraints: const BoxConstraints(
                        minWidth: double.infinity,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Policy",
                              style: h2Style.copyWith(color: Color(0xFF06305A)),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Non-Refundable",
                              style: h4Style,
                            ),
                            Text(
                              "Cancellations are not allowed after booking.",
                              style: desc1Style(Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                      decoration: commonBoxDecorationStyle(containerColor),
                      constraints: const BoxConstraints(
                        minWidth: double.infinity,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Price Details",
                              style: h2Style.copyWith(color: Color(0xFF06305A)),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "FerryNav Ticket(x${widget.numberOfPassenger})",
                                ),
                                Text(
                                  calculatePrice(
                                    cityFrom,
                                    cityDestination,
                                    numberOfPassenger,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Travel Insurance",
                                  style: desc1Style(Colors.black),
                                ),
                                Text(calculateInsurance(int.parse(
                                    widget.numberOfPassenger ?? '0'))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
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
                      calculateTotalPriceFormatted(
                          cityFrom,
                          cityDestination,
                          numberOfPassenger),
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
                    _bookingPending();
                    final cityFrom = widget.cityFrom ?? '';
                    final cityDestination = widget.cityDestination ?? '';
                    final numberOfPassenger =
                        int.tryParse(widget.numberOfPassenger ?? '0') ?? 0;

                    // Call makePayment, which will handle the WebView navigation.
                    makePayment(
                        midtrans, cityFrom, cityDestination, numberOfPassenger);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appBarColor,
                    // Button color (formerly primary)
                    foregroundColor: containerColor,
                    // Text color (formerly onPrimary)
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
