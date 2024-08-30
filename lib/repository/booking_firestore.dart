import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference bookings =
      FirebaseFirestore.instance.collection("bookings");

  Future<void> addNewBookings({
    required String uid,
    required List<int> selectedSeats,
    required String date,
    required String status,
  }) async {
    await bookings.add({
      'uid': uid,
      'seats': selectedSeats,
      'date': date,
      'status': status,
    });
  }
}
