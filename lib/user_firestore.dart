import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  Future<void> addUserDetails({
    required String uid,
    required String name,
    required String email,
    required String phone,
  }) async {
    await users.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
    });
  }
}
