import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smartroombooking/commons/widgets/custom_alert_dialog_box.dart';
import 'package:smartroombooking/commons/widgets/custom_icon_btn.dart';
import 'package:smartroombooking/commons/widgets/custom_room_booking_slot_chips.dart';
import 'package:smartroombooking/commons/widgets/custom_smart_room_booking_card.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class SecondYearSmartRoomBookingScreen extends StatelessWidget {
  const SecondYearSmartRoomBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        return Container(
                          width: double.infinity, // Ensure full width
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              SizedBox(height: 10.h),

                              /// Booking slots
                              CustomRoomBookingSlotChips(),

                              SizedBox(height: 20.h),

                              /// book room slot
                              CustomIconBtn(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomAlertDialogBox(
                                        title: "Booking of Smart Rooms",
                                        content: "Confirmation of smart rooms",
                                        onConfirm: () {},
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
