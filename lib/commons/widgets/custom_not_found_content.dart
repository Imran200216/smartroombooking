import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class CustomNotFoundContent extends StatelessWidget {
  final String imagePath;
  final String notFoundContentDescription;
  final double? imageHeight;
  final double? imageWidth;

  const CustomNotFoundContent({
    super.key,
    required this.imagePath,
    required this.notFoundContentDescription,
    this.imageHeight, // Optional height
    this.imageWidth, // Optional width
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            height: imageHeight ?? 240.h, // Default to 240.h if null
            width: imageWidth ?? 240.w, // Default to 240.w if null
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10.h),
          Text(
            notFoundContentDescription,
            style: TextStyle(
              fontFamily: "Redhat",
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.greyDarkerColor,
            ),
          ),
        ],
      ),
    );
  }
}
