import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smartroombooking/commons/widgets/custom_icon_btn.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class EmailDetailsScreen extends StatelessWidget {
  const EmailDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          title: Text("Profile Setup"),
          titleTextStyle: TextStyle(
            fontFamily: "Redhat",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 1),

                /// image picker
                DottedBorder(
                  borderType: BorderType.Circle,
                  color: AppColors.primaryColor,
                  strokeWidth: 2.w,
                  dashPattern: [6, 4],
                  child: Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 30.w,
                        color: AppColors.primaryColor,
                      ), // Example icon inside
                    ),
                  ),
                ),

                Spacer(flex: 2),

                CustomIconBtn(
                  onTap: () {
                    GoRouter.of(context).pushReplacementNamed("bottomNav");
                  },
                  btnTitle: "Next",
                  iconPath: "login",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
