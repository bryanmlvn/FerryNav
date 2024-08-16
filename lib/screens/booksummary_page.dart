import 'package:flutter/material.dart';
import 'package:ferrynav/user_firestore.dart';
import 'package:ferrynav/styles/style.dart';

class BookSummaryPage extends StatefulWidget {
  static const String id = 'booksummary_page';

  const BookSummaryPage({super.key});

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
                      margin: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
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
                              style: h2Style.copyWith(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
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
                  ],
                ),
              ),
            ),
    );
  }
}
