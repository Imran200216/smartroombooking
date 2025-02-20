import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smartroombooking/commons/widgets/custom_icon_btn.dart';
import 'package:smartroombooking/commons/widgets/custom_text_field.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class AuthForgetPasswordScreen extends StatelessWidget {
  const AuthForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// img
              SvgPicture.asset(
                "assets/img/svg/forget-password.svg",
                height: 230.h,
                width: 230.w,
                fit: BoxFit.cover,
              ),

              SizedBox(height: 30.h),

              /// title text
              Text(
                textAlign: TextAlign.center,
                "Forget Password",
                style: TextStyle(
                  fontFamily: "Redhat",
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleColor,
                  fontSize: 16.sp,
                ),
              ),

              SizedBox(height: 5.h),

              /// sub title color
              Text(
                textAlign: TextAlign.center,
                ''''Please enter your email address to reset your password.''',
                style: TextStyle(
                  fontFamily: "Redhat",
                  fontWeight: FontWeight.w600,
                  color: AppColors.subTitleColor,
                  fontSize: 13.sp,
                ),
              ),

              SizedBox(height: 12.h),

              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                hasBorder: true,
                hintText: "Enter a email address...",
                prefixIcon: Icons.alternate_email,
              ),

              Spacer(),

              CustomIconBtn(
                onTap: () {},
                btnTitle: "Send link",
                iconPath: "login",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
