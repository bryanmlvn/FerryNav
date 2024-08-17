import 'package:flutter/material.dart';
import 'package:ferrynav/user_firestore.dart';
import 'package:ferrynav/styles/style.dart';

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
                            Text(
                              '${widget.cityFrom} - ${widget.cityDestination}',
                              style: h4Style,
                            ),
                            Text(
                              formatSeatNumbers(widget.selectedSeats),
                              style: desc1Style(Colors.black),
                            ),
                            Text(
                              '${widget.date}',
                              style: desc1Style(Colors.black),
                            ),
                            Text(
                              "10.30 BTH -> TBH 15.15 ( SKIP DULU RIBET)",
                              style: desc1Style(Colors.black),
                            )
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
                            SizedBox(height: 4),
                            Text("INI KERJAAN NEXT YA UDAH MAGER")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
