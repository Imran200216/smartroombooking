import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:smartroombooking/commons/widgets/custom_icon_btn.dart';
import 'package:smartroombooking/commons/widgets/custom_outlined_btn.dart';
import 'package:smartroombooking/commons/widgets/custom_text_field.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/core/validator/app_validator.dart';
import 'package:smartroombooking/features/auth/presentation/provider/apple_sign_in_provider.dart';
import 'package:smartroombooking/features/auth/presentation/provider/email_password_auth_provider.dart';
import 'package:smartroombooking/features/auth/presentation/provider/google_sign_in_provider.dart';

class AuthLoginScreen extends StatelessWidget {
  const AuthLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// providers
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);

    final emailPasswordAuthProvider = Provider.of<EmailPasswordAuthProvider>(
      context,
    );

    final appleSignInProvider = Provider.of<AppleSignInProvider>(context);

    /// controllers
    final TextEditingController emailLoginInController =
        TextEditingController();
    final TextEditingController passwordLoginInController =
        TextEditingController();

    /// form key
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    /// clear controllers
    void clearControllers() {
      emailLoginInController.clear();
      passwordLoginInController.clear();
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: formKey,
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
                  validator: AppValidator.validateEmail,
                  textEditingController: emailLoginInController,
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
                  validator: AppValidator.validatePassword,
                  textEditingController: passwordLoginInController,
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
                      GoRouter.of(
                        context,
                      ).pushNamed("authForgetPasswordScreen");
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
                CustomIconBtn(
                  isLoading: emailPasswordAuthProvider.isLoading,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      /// email login functionality
                      emailPasswordAuthProvider
                          .signInWithEmailPassword(
                            emailLoginInController.text.trim(),
                            passwordLoginInController.text.trim(),
                            context,
                          )
                          .then((value) async {
                            /// Save Auth Status in Hive
                            var box = Hive.box('userAuthStatusBox');
                            await box.put('userAuthStatus', true);

                            /// bottom nav
                            GoRouter.of(
                              context,
                            ).pushReplacementNamed("bottomNav");

                            /// clear controllers
                            clearControllers();
                          });
                    }
                  },
                  btnTitle: "Login",
                  iconPath: "login",
                ),

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
                  isLoading: googleSignInProvider.isLoading,
                  onTap: () {
                    /// sign in with google functionality
                    googleSignInProvider.signInWithGoogle(context);
                  },
                  btnTitle: "Sign in with Google",
                  iconPath: "google",
                ),

                SizedBox(height: 12.h),

                /// apple auth btn
                CustomOutlinedBtn(
                  isLoading: appleSignInProvider.isLoading,
                  onTap: () {
                    /// sign in with apple functionality
                    appleSignInProvider.signInWithApple(context);
                  },
                  btnTitle: "Sign in with Apple",
                  iconPath: "apple",
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
      ),
    );
  }
}
