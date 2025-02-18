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
        body: Center(
          child: Text(
            "SmartRoom Booking",
            style: TextStyle(
              fontFamily: "Redhat",
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
