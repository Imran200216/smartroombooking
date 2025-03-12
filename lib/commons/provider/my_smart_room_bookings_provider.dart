import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MySmartRoomBookingsProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _bookings = [];
  bool _isLoading = true;

  List<Map<String, dynamic>> get bookings => _bookings;
  bool get isLoading => _isLoading;

  void listenToBookings() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    FirebaseFirestore.instance
        .collection('SecondYear')
        .where('userUid', isEqualTo: user.uid)
        .snapshots()
        .listen((snapshot) {
          _bookings =
              snapshot.docs
                  .map((doc) => doc.data() as Map<String, dynamic>)
                  .toList();

          _isLoading = false;
          notifyListeners(); // Notify UI only when Firestore updates
        });
  }

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

      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance
              .collection('SecondYear')
              .where('userUid', isEqualTo: currentUserUid)
              .get();

      _bookings =
          querySnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
    } catch (e) {
      print("Error fetching user bookings: $e");
      _bookings = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
