import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smartroombooking/commons/widgets/custom_icon_btn.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class BookNowScreen extends StatelessWidget {
  const BookNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// title text
              Text(
                "User Role Played in Smart Room Booking",
                style: TextStyle(
                  fontFamily: "Redhat",
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleColor,
                  fontSize: 16.sp,
                ),
              ),

              SizedBox(height: 10.h),

              /// sub title color
              Text(
                textAlign: TextAlign.center,
                "Note that your role in our Smart Room Booking App",
                style: TextStyle(
                  fontFamily: "Redhat",
                  fontWeight: FontWeight.w600,
                  color: AppColors.subTitleColor,
                  fontSize: 13.sp,
                ),
              ),

              const Spacer(),

              SvgPicture.asset(
                "assets/img/svg/graduation.svg",
                height: 230.h,
                width: 230.w,
                fit: BoxFit.cover,
              ),

              const Spacer(flex: 3),

              /// second year
              CustomIconBtn(
                onTap: () {
                  /// second year smart room booking screen
                  GoRouter.of(
                    context,
                  ).pushNamed("secondYearSmartRoomBookingScreen");
                },
                btnTitle: "Second year",
                iconPath: "graduate-cap",
              ),

              SizedBox(height: 12.h),

              /// third year
              CustomIconBtn(
                onTap: () {
                  /// third year smart room booking screen
                  GoRouter.of(
                    context,
                  ).pushNamed("thirdYearSmartRoomBookingScreen");
                },
                btnTitle: "Third year",
                iconPath: "graduate-cap",
              ),

              SizedBox(height: 12.h),

              /// fourth year
              CustomIconBtn(
                onTap: () {
                  /// fourth year smart room booking screen
                  GoRouter.of(
                    context,
                  ).pushNamed("fourthYearSmartRoomBookingScreen");
                },
                btnTitle: "Fourth year",
                iconPath: "graduate-cap",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
