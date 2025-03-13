import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartroombooking/core/service/haptic_feedback_service.dart';
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
        HapticFeedbackUtilityService.mediumImpact();

        onTap();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.whiteColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// classroom cached network image
            Container(
              height: 160.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://images.unsplash.com/photo-1571260899304-425eee4c7efc?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Center(
                        child: Image.asset(
                          "assets/img/jpg/splash-logo.jpg",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => Center(
                        child: Image.asset(
                          "assets/img/jpg/splash-logo.jpg",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                ),
              ),
            ),

            /// Room card
            Container(
              margin: EdgeInsets.only(
                left: 12.w,
                right: 12.w,
                top: 6.h,
                bottom: 6.h,
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
