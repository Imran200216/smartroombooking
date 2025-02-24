import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartroombooking/core/service/haptic_feedback_service.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class CustomProfileListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String listTileTitle;
  final VoidCallback onTap;

  const CustomProfileListTile({
    super.key,

    required this.leadingIcon,
    required this.listTileTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        HapticFeedbackUtilityService.mediumImpact();
        onTap();
      },
      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16.h),
      leading: Icon(leadingIcon),
      title: Text(listTileTitle),
      titleTextStyle: TextStyle(
        fontFamily: "Redhat",
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.titleColor,
      ),
    );
  }
}
