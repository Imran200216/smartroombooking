import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smartroombooking/commons/provider/date_picker_provider.dart';
import 'package:smartroombooking/commons/provider/internet_checker_provider.dart';
import 'package:smartroombooking/commons/provider/muti_selection_chip_provider.dart';
import 'package:smartroombooking/commons/widgets/custom_alert_dialog_box.dart';
import 'package:smartroombooking/commons/widgets/custom_icon_btn.dart';
import 'package:smartroombooking/commons/widgets/custom_room_booking_slot_chips.dart';
import 'package:smartroombooking/commons/widgets/custom_smart_room_booking_card.dart';
import 'package:smartroombooking/core/helper/toast_helper.dart';
import 'package:smartroombooking/core/service/notification_service.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/features/second_year/presentation/provider/second_year_smart_room_booking_provider.dart';

class SecondYearSmartRoomBookingScreen extends StatelessWidget {
  const SecondYearSmartRoomBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// providers
    final secondYearSmartRoomBookingProvider =
        Provider.of<SecondYearSmartRoomBookingProvider>(context);

    final multiSelectionChipProvider = Provider.of<MultiSelectionChipProvider>(
      context,
    );

    final internetCheckerProvider = Provider.of<InternetCheckerProvider>(
      context,
    );

    /// firebase current user
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final currentUserName = currentUser?.displayName ?? "No Name";

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Second Year"),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.titleColor,
            fontSize: 16.sp,
            fontFamily: "Redhat",
          ),
          leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// room 301
                CustomSmartRoomBookingCard(
                  smartRoomNo: "Room 201",
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return Consumer<DatePickerProvider>(
                          builder: (context, datePickerProvider, child) {
                            return Container(
                              width: double.infinity, // Ensure full width
                              padding: const EdgeInsets.all(16.0),
                              margin: EdgeInsets.symmetric(vertical: 14.h),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Room no
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Smart Room 201",
                                        style: TextStyle(
                                          fontFamily: "Redhat",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),

                                      /// Date picker button
                                      TextButton(
                                        onPressed: () {
                                          datePickerProvider.pickDate(context);
                                        },
                                        child: Text(
                                          "Pick Date",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryColor,
                                            fontSize: 12.sp,
                                            fontFamily: "Redhat",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10.h),

                                  /// Display selected date in a Chip
                                  datePickerProvider.selectedDate == null
                                      ? SizedBox()
                                      : Chip(
                                        label: Text(
                                          datePickerProvider.formattedDate,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.whiteColor,
                                            fontSize: 12.sp,
                                            fontFamily: "Redhat",
                                          ),
                                        ),
                                        backgroundColor: AppColors.primaryColor,
                                        deleteIcon: Icon(
                                          Icons.close,
                                          color: AppColors.whiteColor,
                                          size: 16.sp,
                                        ),
                                        onDeleted: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CustomAlertDialogBox(
                                                title: "Delete Date",
                                                content:
                                                    "Are you sure you want to delete the picked date?",
                                                onConfirm: () {
                                                  datePickerProvider
                                                      .clearDate();
                                                  ToastHelper.showSuccessToast(
                                                    context: context,
                                                    message:
                                                        "Date deleted successfully",
                                                  );
                                                  GoRouter.of(context).pop();
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),

                                  SizedBox(height: 10.h),

                                  /// Booking slots
                                  CustomRoomBookingSlotChips(),

                                  SizedBox(height: 20.h),

                                  /// Book room slot
                                  CustomIconBtn(
                                    isLoading:
                                        secondYearSmartRoomBookingProvider
                                            .isLoading,
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CustomAlertDialogBox(
                                            title: "Booking of Smart Rooms",
                                            content:
                                                "Confirmation of smart rooms",
                                            onConfirm: () {
                                              if (datePickerProvider
                                                      .selectedDate ==
                                                  null) {
                                                ToastHelper.showErrorToast(
                                                  context: context,
                                                  message:
                                                      "Please select a date first!",
                                                );
                                                return;
                                              }

                                              /// Get selected booking time slots
                                              List<String> selectedTimeSlots =
                                                  multiSelectionChipProvider
                                                      .selectedSlots
                                                      .toList();

                                              if (selectedTimeSlots.isEmpty) {
                                                ToastHelper.showErrorToast(
                                                  context: context,
                                                  message:
                                                      "Please select at least one time slot!",
                                                );
                                                return;
                                              }

                                              /// Check internet connection
                                              if (!internetCheckerProvider
                                                  .isNetworkConnected) {
                                                ToastHelper.showErrorToast(
                                                  context: context,
                                                  message:
                                                      "No internet connection. Please check your network.",
                                                );

                                                return;
                                              }

                                              /// Smart room booking functionality
                                              secondYearSmartRoomBookingProvider
                                                  .addBooking(
                                                    userName: currentUserName,
                                                    roomNumber:
                                                        "Smart Room 201",
                                                    bookingDate:
                                                        datePickerProvider
                                                            .selectedDate!,
                                                    bookingTimePeriods:
                                                        selectedTimeSlots,
                                                    context: context,
                                                  );

                                              /// Store booking date
                                              String bookingDate =
                                                  datePickerProvider
                                                      .formattedDate;

                                              /// Schedule the notification one hour before booking time
                                              DateTime scheduleDate =
                                                  datePickerProvider
                                                      .selectedDate!;
                                              selectedTimeSlots
                                                  .sort(); // Get the earliest slot
                                              String earliestSlot =
                                                  selectedTimeSlots.first;

                                              /// Convert earliest slot to DateTime
                                              List<String> timeParts =
                                                  earliestSlot.split(":");
                                              int hour = int.parse(
                                                timeParts[0],
                                              );
                                              int minute = int.parse(
                                                timeParts[1],
                                              );

                                              DateTime bookingTime = DateTime(
                                                scheduleDate.year,
                                                scheduleDate.month,
                                                scheduleDate.day,
                                                hour,
                                                minute,
                                              );

                                              /// Calculate the reminder time (one hour before booking)
                                              DateTime notificationTime =
                                                  bookingTime.subtract(
                                                    Duration(hours: 1),
                                                  );

                                              /// Show an instant notification if the time has already passed
                                              if (notificationTime.isBefore(
                                                DateTime.now(),
                                              )) {
                                                NotificationService.showInstantNotification(
                                                  "Smart Room Booking",
                                                  "Reminder: Your booking for Smart Room 201 is at $earliestSlot today!",
                                                );
                                              } else {
                                                NotificationService.scheduledNotification(
                                                  "Smart Room Booking",
                                                  "Reminder: Your booking for Smart Room 201 is at $earliestSlot.",
                                                  notificationTime,
                                                );
                                              }

                                              /// Reset selected date & time slots after booking success
                                              datePickerProvider.clearDate();
                                              multiSelectionChipProvider
                                                  .selectedSlots
                                                  .clear();

                                              /// Close dialogs and bottom sheet
                                              GoRouter.of(context).pop();
                                              GoRouter.of(context).pop();

                                              /// Show success notification
                                              NotificationService.showInstantNotification(
                                                currentUserName,
                                                "Smart Room 201 is booked successfully in $bookingDate",
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },

                                    btnTitle: "Book Smart Room",
                                    iconPath: "login",
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  smartRoomDescription:
                      "Check the availabilty slots for booking your smart rooms",
                  smartRoomImagePath: "smart-room",
                ),

                SizedBox(height: 20.h),

                /// room 302
                CustomSmartRoomBookingCard(
                  smartRoomNo: "Room 202",
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return Consumer<DatePickerProvider>(
                          builder: (context, datePickerProvider, child) {
                            return Container(
                              width: double.infinity, // Ensure full width
                              padding: const EdgeInsets.all(16.0),
                              margin: EdgeInsets.symmetric(vertical: 14.h),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Room no
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Smart Room 202",
                                        style: TextStyle(
                                          fontFamily: "Redhat",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),

                                      /// Date picker button
                                      TextButton(
                                        onPressed: () {
                                          datePickerProvider.pickDate(context);
                                        },
                                        child: Text(
                                          "Pick Date",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryColor,
                                            fontSize: 12.sp,
                                            fontFamily: "Redhat",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10.h),

                                  /// Display selected date in a Chip
                                  datePickerProvider.selectedDate == null
                                      ? SizedBox()
                                      : Chip(
                                        label: Text(
                                          datePickerProvider.formattedDate,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.whiteColor,
                                            fontSize: 12.sp,
                                            fontFamily: "Redhat",
                                          ),
                                        ),
                                        backgroundColor: AppColors.primaryColor,
                                        deleteIcon: Icon(
                                          Icons.close,
                                          color: AppColors.whiteColor,
                                          size: 16.sp,
                                        ),
                                        onDeleted: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CustomAlertDialogBox(
                                                title: "Delete Date",
                                                content:
                                                    "Are you sure you want to delete the picked date?",
                                                onConfirm: () {
                                                  datePickerProvider
                                                      .clearDate();
                                                  ToastHelper.showSuccessToast(
                                                    context: context,
                                                    message:
                                                        "Date deleted successfully",
                                                  );
                                                  GoRouter.of(context).pop();
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),

                                  SizedBox(height: 10.h),

                                  /// Booking slots
                                  CustomRoomBookingSlotChips(),

                                  SizedBox(height: 20.h),

                                  /// Book room slot
                                  CustomIconBtn(
                                    isLoading:
                                        secondYearSmartRoomBookingProvider
                                            .isLoading,
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CustomAlertDialogBox(
                                            title: "Booking of Smart Rooms",
                                            content:
                                                "Confirmation of smart rooms",
                                            onConfirm: () {
                                              if (datePickerProvider
                                                      .selectedDate ==
                                                  null) {
                                                ToastHelper.showErrorToast(
                                                  context: context,
                                                  message:
                                                      "Please select a date first!",
                                                );
                                                return;
                                              }

                                              /// Get selected booking time slots
                                              List<String> selectedTimeSlots =
                                                  multiSelectionChipProvider
                                                      .selectedSlots
                                                      .toList();

                                              if (selectedTimeSlots.isEmpty) {
                                                ToastHelper.showErrorToast(
                                                  context: context,
                                                  message:
                                                      "Please select at least one time slot!",
                                                );
                                                return;
                                              }

                                              /// Check internet connection
                                              if (!internetCheckerProvider
                                                  .isNetworkConnected) {
                                                ToastHelper.showErrorToast(
                                                  context: context,
                                                  message:
                                                      "No internet connection. Please check your network.",
                                                );

                                                return;
                                              }

                                              /// Smart room booking functionality
                                              secondYearSmartRoomBookingProvider
                                                  .addBooking(
                                                    userName: currentUserName,
                                                    roomNumber:
                                                        "Smart Room 202",
                                                    bookingDate:
                                                        datePickerProvider
                                                            .selectedDate!,
                                                    bookingTimePeriods:
                                                        selectedTimeSlots,
                                                    context: context,
                                                  );

                                              /// Store booking date
                                              String bookingDate =
                                                  datePickerProvider
                                                      .formattedDate;

                                              /// Schedule the notification one hour before booking time
                                              DateTime scheduleDate =
                                                  datePickerProvider
                                                      .selectedDate!;

                                              /// Get the earliest slot
                                              selectedTimeSlots.sort();
                                              String earliestSlot =
                                                  selectedTimeSlots.first;

                                              /// Convert earliest slot to DateTime
                                              List<String> timeParts =
                                                  earliestSlot.split(":");
                                              int hour = int.parse(
                                                timeParts[0],
                                              );
                                              int minute = int.parse(
                                                timeParts[1],
                                              );

                                              /// booking time
                                              DateTime bookingTime = DateTime(
                                                scheduleDate.year,
                                                scheduleDate.month,
                                                scheduleDate.day,
                                                hour,
                                                minute,
                                              );

                                              /// Calculate the reminder time (one hour before booking)
                                              DateTime notificationTime =
                                                  bookingTime.subtract(
                                                    Duration(hours: 1),
                                                  );

                                              /// Show an instant notification if the time has already passed
                                              if (notificationTime.isBefore(
                                                DateTime.now(),
                                              )) {
                                                NotificationService.showInstantNotification(
                                                  "Smart Room Booking",
                                                  "Reminder: Your booking for Smart Room 202 is at $earliestSlot today!",
                                                );
                                              } else {
                                                NotificationService.scheduledNotification(
                                                  "Smart Room Booking",
                                                  "Reminder: Your booking for Smart Room 202 is at $earliestSlot.",
                                                  notificationTime,
                                                );
                                              }

                                              /// Reset selected date & time slots after booking success
                                              datePickerProvider.clearDate();
                                              multiSelectionChipProvider
                                                  .selectedSlots
                                                  .clear();

                                              /// Close dialogs and bottom sheet
                                              GoRouter.of(context).pop();
                                              GoRouter.of(context).pop();

                                              /// Show success notification
                                              NotificationService.showInstantNotification(
                                                currentUserName,
                                                "Smart Room 202 is booked successfully in $bookingDate",
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },

                                    btnTitle: "Book Smart Room",
                                    iconPath: "login",
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  smartRoomDescription:
                      "Check the availabilty slots for booking your smart rooms",
                  smartRoomImagePath: "smart-room",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
