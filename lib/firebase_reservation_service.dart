import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseReservationService {

  static Future<void> saveReservation(
      Map<String, dynamic> bookingData,
      ) async {

    try {

      print("===== FIREBASE SAVE START =====");

      final user =
          FirebaseAuth.instance.currentUser;

      print("Current User: ${user?.email}");

      if (user == null) {

        print("USER IS NULL");
        return;
      }

      print("Booking Data:");
      print(bookingData);

      await FirebaseFirestore.instance
          .collection("reservations")
          .add({

        ...bookingData,

        "userId": user.uid,

        "createdAt": Timestamp.now(),
      });

      print("===== RESERVATION SAVED =====");

    } catch (e) {

      print("FIRESTORE ERROR:");
      print(e);
    }
  }
}