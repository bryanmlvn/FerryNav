import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<String?> getCurrentUserUID() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<String?> getCurrentUserName() async {
    String? uid = await getCurrentUserUID();
    if (uid != null) {
      DocumentSnapshot doc = await users.doc(uid).get();
      if (doc.exists) {
        return doc.get('name') as String?;
      }
    }
    return null;
  }

  Future<String?> getCurrentUserPhone() async {
    String? uid = await getCurrentUserUID();
    if (uid != null) {
      DocumentSnapshot doc = await users.doc(uid).get();
      if (doc.exists) {
        return doc.get('phone') as String?;
      }
    }
    return null;
  }
}
