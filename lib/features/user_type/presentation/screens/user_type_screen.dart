import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/features/user_type/presentation/provider/user_type_provider.dart';
import 'package:smartroombooking/features/user_type/presentation/widgets/custom_user_type_check_box_list_tile.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// user type provider
    final userTypeProvider = Provider.of<UserTypeProvider>(context);

    /// navigation
    void navigateToLoginScreen(BuildContext context) {
      Future.delayed(const Duration(seconds: 1), () {
        GoRouter.of(context).pushReplacementNamed("authLoginScreen");
      });
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                "assets/img/svg/decision.svg",
                height: 230.h,
                width: 230.w,
                fit: BoxFit.cover,
              ),

              const Spacer(flex: 3),

              /// Admin check box
              CustomUserTypeCheckBoxListTile(
                title: "Admin",
                value: userTypeProvider.isAdmin,
                onChanged: (value) {
                  userTypeProvider.toggleAdmin(value ?? false);

                  navigateToLoginScreen(context);
                },
              ),

              SizedBox(height: 12.h),

              /// Staff Checkbox
              CustomUserTypeCheckBoxListTile(
                title: "Staff",
                value: userTypeProvider.isStaff,
                onChanged: (value) {
                  userTypeProvider.toggleStaff(value ?? false);

                  navigateToLoginScreen(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
