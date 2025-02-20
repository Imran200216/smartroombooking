import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      /// on boarding screen
      GoRouter.of(context).pushReplacementNamed("onBoardingScreen");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Center(
          child: Column(
            spacing: 12.h,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// college logo
              Image.asset(
                "assets/img/jpg/splash-logo.jpg",
                height: 150.h,
                width: 150.w,
                fit: BoxFit.cover,
              ),

              /// text
              Text(
                textAlign: TextAlign.start,
                "Smart Room Booking",
                style: TextStyle(
                  fontFamily: "Redhat",
                  fontWeight: FontWeight.w800,
                  color: AppColors.logoRedPrimaryColor,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
