import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartroombooking/core/service/custom_haptic.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class CustomSmartRoomBookingCard extends StatelessWidget {
  final String smartRoomNo;
  final VoidCallback onTap;
  final String smartRoomDescription;
  final String smartRoomImagePath;

  const CustomSmartRoomBookingCard({
    super.key,
    required this.smartRoomNo,
    required this.onTap,
    required this.smartRoomDescription,
    required this.smartRoomImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedbackUtility.mediumImpact();

        onTap();
      },
      child: Container(
        height: 230.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.whiteColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
                image: DecorationImage(
                  image: AssetImage("assets/img/jpg/$smartRoomImagePath.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 10.h),

            /// Room card
            Container(
              margin: EdgeInsets.only(
                left: 12.w,
                right: 12.w,
                top: 4.h,
                bottom: 4.h,
              ),
              child: Column(
                spacing: 2.h,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// room no
                  Text(
                    textAlign: TextAlign.start,
                    smartRoomNo,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.titleColor,
                      fontSize: 14.sp,
                      fontFamily: "Redhat",
                    ),
                  ),

                  /// room no
                  Text(
                    textAlign: TextAlign.start,
                    smartRoomDescription,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.subTitleColor,
                      fontSize: 12.sp,
                      fontFamily: "Redhat",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
