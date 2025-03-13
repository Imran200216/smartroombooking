import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class SnackBarHelper {
  static void showFailureSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        closeIconColor: AppColors.whiteColor,
        content: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            fontFamily: "Redhat",
            color: AppColors.whiteColor,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.failureToastColor,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
