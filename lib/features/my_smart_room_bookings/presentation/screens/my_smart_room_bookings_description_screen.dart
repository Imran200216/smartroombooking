import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smartroombooking/commons/widgets/custom_chip.dart';
import 'package:smartroombooking/commons/widgets/custom_text_field.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class MySmartRoomBookingsDescriptionScreen extends StatelessWidget {
  final String userName;
  final String roomNumber;
  final String bookingDate;
  final List bookingTimePeriods;

  const MySmartRoomBookingsDescriptionScreen({
    super.key,
    required this.userName,
    required this.roomNumber,
    required this.bookingDate,
    required this.bookingTimePeriods,
  });

  @override
  Widget build(BuildContext context) {
    /// Convert the received String back to DateTime
    DateTime parsedDate = DateTime.tryParse(bookingDate) ?? DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

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

        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// user name text
              Text(
                "User",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleColor,
                  fontFamily: "Redhat",
                ),
              ),

              SizedBox(height: 8.h),

              /// user name text field
              CustomTextField(
                hintText: "user Name",
                prefixIcon: Icons.person,
                hasBorder: true,
                readOnly: true,
                textEditingController: TextEditingController(text: userName),
              ),

              SizedBox(height: 20.h),

              /// Room Number text
              Text(
                "Room Number",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleColor,
                  fontFamily: "Redhat",
                ),
              ),

              SizedBox(height: 8.h),

              /// room number text field
              CustomTextField(
                hintText: "Room number",
                prefixIcon: Icons.room_preferences_outlined,
                hasBorder: true,
                readOnly: true,
                textEditingController: TextEditingController(text: roomNumber),
              ),

              SizedBox(height: 20.h),

              /// booking date text
              Text(
                "Date of Booking",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleColor,
                  fontFamily: "Redhat",
                ),
              ),

              SizedBox(height: 8.h),

              /// booking text field
              CustomTextField(
                hintText: "Booking Date",
                prefixIcon: Icons.date_range,
                hasBorder: true,
                readOnly: true,
                textEditingController: TextEditingController(
                  text: formattedDate,
                ),
              ),

              SizedBox(height: 20.h),

              /// booking date text
              Text(
                "Smart Room Booking Time Periods",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleColor,
                  fontFamily: "Redhat",
                ),
              ),

              SizedBox(height: 8.h),

              /// booking dates
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children:
                    bookingTimePeriods
                        .map((period) => CustomChip(label: period.toString()))
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
