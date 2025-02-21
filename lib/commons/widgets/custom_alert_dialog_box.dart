import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smartroombooking/core/service/custom_haptic.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class CustomAlertDialogBox extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const CustomAlertDialogBox({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(title),
      titleTextStyle: TextStyle(
        color: AppColors.titleColor,
        fontWeight: FontWeight.w700,
        fontFamily: "Redhat",
        fontSize: 16.sp,
      ),
      content: Text(content),
      contentTextStyle: TextStyle(
        color: AppColors.greyDarkerColor,
        fontWeight: FontWeight.w500,
        fontFamily: "Redhat",
        fontSize: 12.sp,
      ),
      actions: [
        TextButton(
          onPressed: () {
            HapticFeedbackUtility.mediumImpact();
            GoRouter.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              color: AppColors.greyDarkerColor,
              fontWeight: FontWeight.w600,
              fontFamily: "Redhat",
              fontSize: 13.sp,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            HapticFeedbackUtility.mediumImpact();
            onConfirm();
          },
          child: Text(
            "Confirm",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontFamily: "Redhat",
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}
