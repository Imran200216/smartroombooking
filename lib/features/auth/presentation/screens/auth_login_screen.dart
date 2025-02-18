import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smartroombooking/commons/widgets/custom_icon_btn.dart';
import 'package:smartroombooking/commons/widgets/custom_outlined_btn.dart';
import 'package:smartroombooking/commons/widgets/custom_text_field.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class AuthLoginScreen extends StatelessWidget {
  const AuthLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// title text
              Text(
                "Log Account",
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
                "Hello, Welcome back to our account!",
                style: TextStyle(
                  fontFamily: "Redhat",
                  fontWeight: FontWeight.w600,
                  color: AppColors.subTitleColor,
                  fontSize: 13.sp,
                ),
              ),

              SizedBox(height: 30.h),

              /// email address text
              Text(
                textAlign: TextAlign.center,
                "Email",
                style: TextStyle(
                  fontFamily: "Redhat",
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleColor,
                  fontSize: 13.sp,
                ),
              ),

              SizedBox(height: 10.h),

              /// email text field
              CustomTextField(
                hasBorder: true,
                hintText: "john@gmail.com",
                prefixIcon: Icons.alternate_email,
              ),

              SizedBox(height: 20.h),

              /// password text
              Text(
                textAlign: TextAlign.center,
                "Password",
                style: TextStyle(
                  fontFamily: "Redhat",
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleColor,
                  fontSize: 13.sp,
                ),
              ),

              SizedBox(height: 10.h),

              /// password text field
              CustomTextField(
                isPassword: true,
                hasBorder: true,
                hintText: "***************",
                prefixIcon: Icons.lock_outline,
              ),

              SizedBox(height: 5.h),

              /// forget password text btn
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    /// forget password screen
                    GoRouter.of(context).pushNamed("authForgetPasswordScreen");
                  },
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                      fontFamily: "Redhat",
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// login btn
              CustomIconBtn(onTap: () {}, btnTitle: "Login", iconPath: "login"),

              SizedBox(height: 20.h),

              /// divider content
              Row(
                spacing: 8.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: AppColors.subTitleColor,
                    ),
                  ),

                  Text(
                    "Or Log In With",
                    style: TextStyle(
                      fontFamily: "Redhat",
                      fontWeight: FontWeight.w700,
                      color: AppColors.subTitleColor,
                      fontSize: 13.sp,
                    ),
                  ),

                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: AppColors.subTitleColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              /// google auth btn
              CustomOutlinedBtn(
                onTap: () {},
                btnTitle: "Sign in with Google",
                iconPath: "google",
              ),

              Spacer(),

              Row(
                spacing: 3.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontFamily: "Redhat",
                      fontWeight: FontWeight.w500,
                      color: AppColors.subTitleColor,
                      fontSize: 13.sp,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      /// sign up screen
                      GoRouter.of(context).pushNamed("authSignUpScreen");
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontFamily: "Redhat",
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
