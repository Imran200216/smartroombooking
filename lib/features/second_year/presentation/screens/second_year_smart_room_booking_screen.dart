import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smartroombooking/commons/provider/date_picker_provider.dart';
import 'package:smartroombooking/commons/provider/muti_selection_chip_provider.dart';
import 'package:smartroombooking/commons/widgets/custom_alert_dialog_box.dart';
import 'package:smartroombooking/commons/widgets/custom_icon_btn.dart';
import 'package:smartroombooking/commons/widgets/custom_room_booking_slot_chips.dart';
import 'package:smartroombooking/commons/widgets/custom_smart_room_booking_card.dart';
import 'package:smartroombooking/core/helper/toast_helper.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/features/second_year/presentation/provider/second_year_smart_room_booking_provider.dart';

class SecondYearSmartRoomBookingScreen extends StatelessWidget {
  const SecondYearSmartRoomBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// providers
    final secondYearSmartRoomBookingProvider =
        Provider.of<SecondYearSmartRoomBookingProvider>(context);

    // final datePickerProvider = Provider.of<DatePickerProvider>(context);

    final multiSelectionChipProvider = Provider.of<MultiSelectionChipProvider>(
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
                /// room 1
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
                                      /// Room no
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
                                          /// date picker functionality
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
                                                  /// Remove selected date
                                                  datePickerProvider
                                                      .clearDate();

                                                  /// deleted date toast success
                                                  ToastHelper.showSuccessToast(
                                                    context: context,
                                                    message:
                                                        "Date deleted successfully",
                                                  );

                                                  /// Close the alert dialog first
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

                                              /// Ensure at least one time slot is selected
                                              if (selectedTimeSlots.isEmpty) {
                                                ToastHelper.showErrorToast(
                                                  context: context,
                                                  message:
                                                      "Please select at least one time slot!",
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

                                              /// Reset selected date & time slots after booking success
                                              datePickerProvider.clearDate();
                                              multiSelectionChipProvider
                                                  .selectedSlots
                                                  .clear();

                                              /// Close dialog
                                              GoRouter.of(context).pop();

                                              /// Close the bottom sheet after successful booking
                                              GoRouter.of(context).pop();
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

                /// room 2
                CustomSmartRoomBookingCard(
                  smartRoomNo: "Room 202",
                  onTap: () {},
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
