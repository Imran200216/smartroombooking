import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'package:provider/provider.dart';
import 'package:smartroombooking/commons/widgets/custom_drop_down_text_field.dart';
import 'package:smartroombooking/commons/widgets/custom_icon_btn.dart';
import 'package:smartroombooking/commons/widgets/custom_outlined_btn.dart';
import 'package:smartroombooking/commons/widgets/custom_text_field.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/features/auth/presentation/provider/google_sign_in_provider.dart';
import 'package:smartroombooking/features/auth/presentation/provider/user_role_provider.dart';

class AuthSignUpScreen extends StatelessWidget {
  const AuthSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// user role type
    String? selectedRole;

    /// providers
    final userRoleProvider = Provider.of<UserRoleProvider>(context);

    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// title text
                Text(
                  "Sign Up Account",
                  style: TextStyle(
                    fontFamily: "Redhat",
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleColor,
                    fontSize: 16.sp,
                  ),
                ),

                SizedBox(height: 10.h),

                /// sub title text
                Text(
                  "Hello, Welcome back to our account!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Redhat",
                    fontWeight: FontWeight.w600,
                    color: AppColors.subTitleColor,
                    fontSize: 13.sp,
                  ),
                ),

                SizedBox(height: 10.h),

                /// Username text
                Text(
                  "Username",
                  style: TextStyle(
                    fontFamily: "Redhat",
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleColor,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 10.h),

                /// user name text field
                CustomTextField(
                  hasBorder: true,
                  hintText: "johndoe",
                  prefixIcon: Icons.person_outline,
                ),

                SizedBox(height: 10.h),

                /// Email Field
                Text(
                  "Email",
                  style: TextStyle(
                    fontFamily: "Redhat",
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleColor,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 10.h),

                /// user name text field
                CustomTextField(
                  hasBorder: true,
                  hintText: "john@gmail.com",
                  prefixIcon: Icons.alternate_email,
                ),

                SizedBox(height: 10.h),

                /// Password Field
                Text(
                  "Create Password",
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

                SizedBox(height: 10.h),

                /// Confirm Password Field
                Text(
                  "Confirm Password",
                  style: TextStyle(
                    fontFamily: "Redhat",
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleColor,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 10.h),

                /// confirm password text field
                CustomTextField(
                  isPassword: true,
                  hasBorder: true,
                  hintText: "***************",
                  prefixIcon: Icons.lock_outline,
                ),

                SizedBox(height: 10.h),

                /// User Type
                Text(
                  "User Type",
                  style: TextStyle(
                    fontFamily: "Redhat",
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleColor,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 10.h),

                /// User Type text field
                CustomDropdownTextField(
                  hintText: "Select Role",
                  prefixIcon: Icons.person_outline,
                  items: ["Admin", "Staff", "Guest"],
                  selectedValue: selectedRole,
                  hasBorder: true,
                  onChanged: (value) {
                    userRoleProvider.setSelectedRole(value!);
                  },
                ),

                SizedBox(height: 20.h),

                /// Sign Up Button
                CustomIconBtn(
                  onTap: () {
                    /// bottom nav
                    GoRouter.of(context).pushNamed("bottomNav");
                  },
                  btnTitle: "Sign Up",
                  iconPath: "login",
                ),

                SizedBox(height: 20.h),

                /// Divider with "Or Log In With"
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: AppColors.subTitleColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        "Or Log In With",
                        style: TextStyle(
                          fontFamily: "Redhat",
                          fontWeight: FontWeight.w700,
                          color: AppColors.subTitleColor,
                          fontSize: 13.sp,
                        ),
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

                /// Google Sign Up Button
                CustomOutlinedBtn(
                  isLoading: googleSignInProvider.isLoading,
                  onTap: () {
                    /// sign in with google functionality
                    googleSignInProvider.signInWithGoogle(context).then((
                      value,
                    ) async {
                      GoRouter.of(context).pushReplacementNamed("bottomNav");
                    });
                  },
                  btnTitle: "Sign Up with Google",
                  iconPath: "google",
                ),

                SizedBox(height: 20.h),

                /// Already have an account? Login
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontFamily: "Redhat",
                        fontWeight: FontWeight.w500,
                        color: AppColors.subTitleColor,
                        fontSize: 13.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        /// login screen
                        GoRouter.of(context).pushNamed("authLoginScreen");
                      },
                      child: Text(
                        "Login In",
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

                SizedBox(height: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
