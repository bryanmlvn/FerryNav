import 'package:flutter/material.dart';
import 'package:ferrynav/user_firestore.dart';

class BookSummaryPage extends StatefulWidget {
  static const String id = 'booksummary_page';

  @override
  _BookSummaryPageState createState() => _BookSummaryPageState();
}

class _BookSummaryPageState extends State<BookSummaryPage> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserName();
  }

  Future<void> _loadCurrentUserName() async {
    FirestoreService firestoreService = FirestoreService();
    String? name = await firestoreService.getCurrentUserName();
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Summary'),
      ),
      body: userName == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Text(userName != null
                  ? 'Current User Name: $userName'
                  : 'User name not found'),
            ),
    );
  }
}
