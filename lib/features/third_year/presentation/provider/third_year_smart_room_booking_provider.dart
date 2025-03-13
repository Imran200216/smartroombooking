import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartroombooking/core/helper/toast_helper.dart';

class ThirdYearSmartRoomBookingProvider extends ChangeNotifier {
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

      /// Get the start and end of the current and next week
      DateTime now = DateTime.now();
      DateTime startOfCurrentWeek = now.subtract(
        Duration(days: now.weekday - 1),
      ); // Monday of current week
      DateTime endOfCurrentWeek = startOfCurrentWeek.add(
        const Duration(days: 6),
      ); // Sunday of current week

      DateTime startOfNextWeek = endOfCurrentWeek.add(
        const Duration(days: 1),
      ); // Monday of next week
      DateTime endOfNextWeek = startOfNextWeek.add(
        const Duration(days: 6),
      ); // Sunday of next week

      /// Convert start and end of weeks to UTC timestamps for Fire store query
      Timestamp startOfCurrentWeekTimestamp = Timestamp.fromDate(
        DateTime.utc(
          startOfCurrentWeek.year,
          startOfCurrentWeek.month,
          startOfCurrentWeek.day,
          0,
          0,
          0,
        ),
      );
      Timestamp endOfCurrentWeekTimestamp = Timestamp.fromDate(
        DateTime.utc(
          endOfCurrentWeek.year,
          endOfCurrentWeek.month,
          endOfCurrentWeek.day,
          23,
          59,
          59,
        ),
      );

      Timestamp startOfNextWeekTimestamp = Timestamp.fromDate(
        DateTime.utc(
          startOfNextWeek.year,
          startOfNextWeek.month,
          startOfNextWeek.day,
          0,
          0,
          0,
        ),
      );
      Timestamp endOfNextWeekTimestamp = Timestamp.fromDate(
        DateTime.utc(
          endOfNextWeek.year,
          endOfNextWeek.month,
          endOfNextWeek.day,
          23,
          59,
          59,
        ),
      );

      /// Ensure `bookingDate` is always stored as a `Timestamp`
      Timestamp bookingTimestamp = Timestamp.fromDate(bookingDate);

      /// Determine which week the booking falls into
      bool isCurrentWeek =
          bookingDate.isAfter(startOfCurrentWeek) &&
          bookingDate.isBefore(endOfCurrentWeek.add(const Duration(days: 1)));
      bool isNextWeek =
          bookingDate.isAfter(startOfNextWeek) &&
          bookingDate.isBefore(endOfNextWeek.add(const Duration(days: 1)));

      if (!isCurrentWeek && !isNextWeek) {
        _isLoading = false;
        notifyListeners();
        ToastHelper.showErrorToast(
          context: context,
          message: "You can only book for the current or next week!",
        );
        return;
      }

      /// Query Firestore for the user's bookings in the appropriate week
      QuerySnapshot userBookings =
          await _firestore
              .collection("ThirdYear")
              .where("userUid", isEqualTo: userUid)
              .where(
                "bookingDate",
                isGreaterThanOrEqualTo:
                    isCurrentWeek
                        ? startOfCurrentWeekTimestamp
                        : startOfNextWeekTimestamp,
              )
              .where(
                "bookingDate",
                isLessThanOrEqualTo:
                    isCurrentWeek
                        ? endOfCurrentWeekTimestamp
                        : endOfNextWeekTimestamp,
              )
              .get();

      /// Print the number of bookings for debugging
      print(
        "User $userName has ${userBookings.docs.length} bookings in the selected week.",
      );

      /// If user already has 3 or more bookings, show an error and stop
      if (userBookings.docs.length >= 3) {
        _isLoading = false;
        notifyListeners();
        ToastHelper.showErrorToast(
          context: context,
          message: "You have reached your limit of 3 bookings for this week!",
        );
        return;
      }

      /// Proceed with booking since the user has less than 3 bookings in the selected week
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
