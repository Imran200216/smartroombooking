import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartroombooking/core/helper/toast_helper.dart';

class SecondYearSmartRoomBookingProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> addBooking({
    required String userName,
    required String roomNumber,
    required DateTime bookingDate,
    required List<String> bookingTimePeriods,
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      /// Get the current user's UID
      String? userUid = _auth.currentUser?.uid;
      if (userUid == null) {
        ToastHelper.showErrorToast(
          context: context,
          message: "User not authenticated! Please sign in.",
        );
        _isLoading = false;
        notifyListeners();
        return;
      }

      /// Get the start (Monday) and end (Sunday) of the current week
      DateTime now = DateTime.now();
      DateTime startOfWeek = now.subtract(
        Duration(days: now.weekday - 1),
      ); // Monday
      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6)); // Sunday

      /// Convert start and end of the week to UTC timestamps for Firestore query
      Timestamp startTimestamp = Timestamp.fromDate(
        DateTime.utc(
          startOfWeek.year,
          startOfWeek.month,
          startOfWeek.day,
          0,
          0,
          0,
        ),
      );
      Timestamp endTimestamp = Timestamp.fromDate(
        DateTime.utc(
          endOfWeek.year,
          endOfWeek.month,
          endOfWeek.day,
          23,
          59,
          59,
        ),
      );

      /// Ensure `bookingDate` is always stored as a `Timestamp`
      Timestamp bookingTimestamp = Timestamp.fromDate(bookingDate);

      /// Query Firestore for the user's bookings within this week
      QuerySnapshot userBookings =
          await _firestore
              .collection("SecondYear")
              .where("userUid", isEqualTo: userUid)
              .where("bookingDate", isGreaterThanOrEqualTo: startTimestamp)
              .where("bookingDate", isLessThanOrEqualTo: endTimestamp)
              .get();

      /// Print the number of bookings for debugging
      print(
        "User $userName has ${userBookings.docs.length} bookings this week.",
      );

      /// If user already has 3 or more bookings, show an error and stop
      if (userBookings.docs.length >= 3) {
        _isLoading = false;
        notifyListeners();
        ToastHelper.showErrorToast(
          context: context,
          message: "You have reached your limit of 3 bookings per week!",
        );
        return;
      }

      /// Proceed with booking since the user has less than 3 bookings this week
      await _firestore.collection("SecondYear").add({
        "userName": userName,
        "userUid": userUid,
        "roomNumber": roomNumber,
        "bookingDate": bookingTimestamp, // Store as a proper Timestamp
        "bookingTimePeriods": bookingTimePeriods,
        "createdAt": FieldValue.serverTimestamp(),
      });

      _isLoading = false;
      notifyListeners();

      /// Show success message
      ToastHelper.showSuccessToast(
        context: context,
        message: "Booking added successfully!",
      );
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      /// Show error message
      ToastHelper.showErrorToast(
        context: context,
        message: "Booking failed! Please try again.",
      );
    }
  }
}
