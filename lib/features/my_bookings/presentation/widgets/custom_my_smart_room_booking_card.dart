import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class CustomMySmartRoomBookingCard extends StatelessWidget {
  final String personName;
  final String roomNo;

  const CustomMySmartRoomBookingCard({
    super.key,
    required this.personName,
    required this.roomNo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.subTitleColor, width: 0.5),
        // Border color & width
        borderRadius: BorderRadius.circular(12.r), // Rounded corners
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        // Padding for better spacing
        leading: CircleAvatar(
          radius: 20.r,
          backgroundImage: AssetImage("assets/img/jpg/splash-logo.jpg"),
        ),
        title: Text(
          personName,
          style: TextStyle(
            fontFamily: "Redhat",
            fontWeight: FontWeight.w700,
            color: AppColors.titleColor,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Text(
          roomNo,
          style: TextStyle(
            fontFamily: "Redhat",
            fontWeight: FontWeight.w600,
            color: AppColors.subTitleColor,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
