import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MySmartRoomBookingsProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _bookings = [];
  bool _isLoading = true;

  List<Map<String, dynamic>> get bookings => _bookings;

  bool get isLoading => _isLoading;

  /// **Fetch bookings from multiple collections**
  Future<void> fetchCurrentUserBookings() async {
    _isLoading = true;
    notifyListeners();

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _bookings = [];
        _isLoading = false;
        notifyListeners();
        return;
      }

      String currentUserUid = user.uid;

      /// **List of collections to fetch**
      List<String> collections = ['SecondYear', 'ThirdYear', 'FourthYear'];

      List<Map<String, dynamic>> allBookings = [];

      /// **Fetch bookings from each collection**
      for (String collection in collections) {
        QuerySnapshot querySnapshot =
            await FirebaseFirestore.instance
                .collection(collection)
                .where('userUid', isEqualTo: currentUserUid)
                .get();

        /// **Add fetched documents to list**
        allBookings.addAll(
          querySnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList(),
        );
      }

      _bookings = allBookings;
    } catch (e) {
      print("Error fetching user bookings: $e");
      _bookings = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  /// **Listen to real-time updates from multiple collections**
  void listenToBookings() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    List<String> collections = ['SecondYear', 'ThirdYear', 'FourthYear'];
    List<Map<String, dynamic>> allBookings = [];

    for (String collection in collections) {
      FirebaseFirestore.instance
          .collection(collection)
          .where('userUid', isEqualTo: user.uid)
          .snapshots()
          .listen((snapshot) {
            allBookings.addAll(
              snapshot.docs
                  .map((doc) => doc.data() as Map<String, dynamic>)
                  .toList(),
            );

            _bookings = allBookings;
            _isLoading = false;
            notifyListeners();
          });
    }
  }
}
