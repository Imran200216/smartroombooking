import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
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
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    /// Check if user has completed "Get Started" flow
    var userGetStartedBox = Hive.box("userGetStartedStatusBox");
    bool userGetStartedStatus = userGetStartedBox.get(
      "userGetStartedStatus",
      defaultValue: false,
    );

    /// Check if user is authenticated
    var userAuthBox = Hive.box("userAuthStatusBox");
    bool userAuthStatus = userAuthBox.get(
      "userAuthStatus",
      defaultValue: false,
    );

    if (userGetStartedStatus && userAuthStatus) {
      /// Navigate to BottomNav if both conditions are true
      GoRouter.of(context).pushReplacementNamed("bottomNav");
    } else if (userGetStartedStatus) {
      /// Navigate to BottomNav if both conditions are true
      GoRouter.of(context).pushReplacementNamed("authLoginScreen");
    } else {
      /// Navigate to on boarding screen if conditions are not met
      GoRouter.of(context).pushReplacementNamed("onBoardingScreen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// College logo
              Image.asset(
                "assets/img/jpg/splash-logo.jpg",
                height: 150.h,
                width: 150.w,
                fit: BoxFit.cover,
              ),

              SizedBox(height: 12.h),

              /// App title
              Text(
                "Smart Room Booking",
                textAlign: TextAlign.center,
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
