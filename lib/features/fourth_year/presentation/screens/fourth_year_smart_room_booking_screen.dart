import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smartroombooking/commons/widgets/custom_smart_room_booking_card.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class FourthYearSmartRoomBookingScreen extends StatelessWidget {
  const FourthYearSmartRoomBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Fourth Year"),
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
                  smartRoomNo: "Room 401",
                  onTap: () {},
                  smartRoomDescription:
                      "Check the availabilty slots for booking your smart rooms",
                  smartRoomImagePath: "smart-room",
                ),

                SizedBox(height: 20.h),

                /// room 2
                CustomSmartRoomBookingCard(
                  smartRoomNo: "Room 402",
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
