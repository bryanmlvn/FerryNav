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

  Future<int> getAvailableSeatCount(
      String date, String from, String destination) async {
    int totalSeats = 200;
    int unavailableSeats = 0;

    // Fetch bookings for the given date
    QuerySnapshot bookingsSnapshot =
        await bookings.where('date', isEqualTo: date).get();

    DateTime now = DateTime.now();

    for (var doc in bookingsSnapshot.docs) {
      Map<String, dynamic> bookingData = doc.data() as Map<String, dynamic>;

      // Check if 'from' and 'destination' match the provided values
      if (bookingData['from'] == from &&
          bookingData['destination'] == destination) {
        String status = bookingData['status'];
        Timestamp createdAt = bookingData['createdAt'];

        if (status == 'pending') {
          DateTime createdTime = createdAt.toDate();
          Duration timeElapsed = now.difference(createdTime);

          // Debugging: Print the booking details
          print('Booking ID: ${bookingData['bookingID']}');
          print('Created At: $createdTime');
          print('Status: $status');
          print('Time Elapsed: ${timeElapsed.inMinutes} minutes');

          // Check if less than 30 minutes have passed since the booking
          if (timeElapsed.inMinutes < 30) {
            // Check if 'seats' exists and is an array, and add the length to unavailableSeats
            if (bookingData.containsKey('seats') &&
                bookingData['seats'] is List) {
              List<dynamic> seats = bookingData['seats'];
              unavailableSeats += seats
                  .length; // Increment unavailable seats by the number of booked seats
            }
          }
        }
      }
    }

    // Calculate available seats
    int availableSeats = totalSeats - unavailableSeats;

    // Debugging: Print the final result
    print('Total Seats: $totalSeats');
    print('Unavailable Seats: $unavailableSeats');
    print('Available Seats: $availableSeats');

    return availableSeats;
  }
}
