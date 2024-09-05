import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference bookings =
      FirebaseFirestore.instance.collection("bookings");

  String generateBookingId() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final randomPart = random.nextInt(100000).toString();
    return '$timestamp-$randomPart';
  }

  Future<void> addNewBookings({
    required String uid,
    required List<int> selectedSeats,
    required String date,
    required String status,
    required String from,
    required String destination,
  }) async {
    String bookingId = generateBookingId();

    await bookings.doc(bookingId).set({
      'uid': uid,
      'seats': selectedSeats,
      'date': date,
      'status': status,
      'createdAt': FieldValue.serverTimestamp(),
      'bookingID': generateBookingId(),
      'from': from,
      'destination': destination,
    });

    _scheduleCancellation(bookingId);
  }

  Future<void> _scheduleCancellation(String bookingId) async {
    await Future.delayed(Duration(minutes: 30));

    DocumentSnapshot bookingSnapshot = await bookings.doc(bookingId).get();

    if (bookingSnapshot.exists) {
      String currentStatus = bookingSnapshot['status'];
      if (currentStatus == 'pending') {
        await bookings.doc(bookingId).update({'status': 'canceled'});
      }
    }
  }
}
