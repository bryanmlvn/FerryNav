import 'package:flutter/material.dart';
import 'package:ferrynav/user_firestore.dart';
import 'package:ferrynav/styles/style.dart';

class BookSummaryPage extends StatefulWidget {
  static const String id = 'booksummary_page';

  @override
  _BookSummaryPageState createState() => _BookSummaryPageState();
}

class _BookSummaryPageState extends State<BookSummaryPage> {
  String? userName;
  String? userPhone;

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
      body: SingleChildScrollView(
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
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Payment Information",
                          style: h2Style.copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          userName!,
                          style: desc1Style(Colors.black),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          userPhone!,
                          style: desc1Style(Colors.black),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
