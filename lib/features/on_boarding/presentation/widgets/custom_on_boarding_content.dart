import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class CustomOnBoardingContent extends StatelessWidget {
  final String onBoardingImgPath;
  final String onBoardingTitle;
  final String onBoardingSubTitle;

  const CustomOnBoardingContent({
    super.key,
    required this.onBoardingImgPath,
    required this.onBoardingTitle,
    required this.onBoardingSubTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// svg image
        SvgPicture.asset(
          "assets/img/svg/$onBoardingImgPath.svg",
          height: 280.h,
          width: 280.w,
          fit: BoxFit.cover,
        ),

        SizedBox(height: 20.h),

        /// title text
        Text(
          onBoardingTitle,
          style: TextStyle(
            fontFamily: "Redhat",
            fontWeight: FontWeight.w700,
            color: AppColors.titleColor,
            fontSize: 16.sp,
          ),
        ),

        SizedBox(height: 10.h),

        /// sub title color
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            textAlign: TextAlign.center,
            onBoardingSubTitle,
            style: TextStyle(
              fontFamily: "Redhat",
              fontWeight: FontWeight.w600,
              color: AppColors.subTitleColor,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}
