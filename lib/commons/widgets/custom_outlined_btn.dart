import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartroombooking/core/service/haptic_feedback_service.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class CustomOutlinedBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String btnTitle;
  final bool isLoading;
  final String iconPath;

  const CustomOutlinedBtn({
    super.key,
    required this.onTap,
    required this.btnTitle,
    this.isLoading = false,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          isLoading
              ? null
              : () {
                HapticFeedbackUtilityService.lightImpact();

                onTap();
              }, // Disable tap when loading
      child: Container(
        height: 36.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: AppColors.outlinedBtnBorderColor, width: 1),
          color: isLoading ? Colors.transparent : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isLoading)
              SvgPicture.asset(
                "assets/icons/$iconPath.svg",
                height: 17.w,
                width: 17.w,
              ),
            if (!isLoading) SizedBox(width: 10.w),
            // Add spacing between icon and text
            isLoading
                ? SizedBox(
                  height: 20.w,
                  width: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                )
                : Text(
                  btnTitle,
                  style: TextStyle(
                    fontFamily: "RedHat",
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleColor,
                    fontSize: 13.sp,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
