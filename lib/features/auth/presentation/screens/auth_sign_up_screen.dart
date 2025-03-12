import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart' show GoRouter;
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

class AuthSignUpScreen extends StatefulWidget {
  const AuthSignUpScreen({super.key});

  @override
  State<AuthSignUpScreen> createState() => _AuthSignUpScreenState();
}

class _AuthSignUpScreenState extends State<AuthSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    /// user role type
    String? selectedRole;

    /// providers
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);

    final emailPasswordAuthProvider = Provider.of<EmailPasswordAuthProvider>(
      context,
    );

    final appleSignInProvider = Provider.of<AppleSignInProvider>(context);

    /// controllers
    final TextEditingController userNameSignUpController =
        TextEditingController();
    final TextEditingController emailSignUpController = TextEditingController();
    final TextEditingController passwordSignUpController =
        TextEditingController();
    final TextEditingController confirmPasswordSignUpController =
        TextEditingController();

    /// clear all controllers
    void clearAllControllers() {
      userNameSignUpController.clear();
      emailSignUpController.clear();
      passwordSignUpController.clear();
      confirmPasswordSignUpController.clear();
    }

    /// form key
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Form(
              key: formKey,
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
                    textEditingController: userNameSignUpController,
                    hasBorder: true,
                    hintText: "johndoe",
                    prefixIcon: Icons.person_outline,
                    validator: AppValidator.validateName,
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

                  /// email text field
                  CustomTextField(
                    textEditingController: emailSignUpController,
                    hasBorder: true,
                    hintText: "john@gmail.com",
                    prefixIcon: Icons.alternate_email,
                    validator: AppValidator.validateEmail,
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
                    textEditingController: passwordSignUpController,
                    isPassword: true,
                    hasBorder: true,
                    hintText: "***************",
                    prefixIcon: Icons.lock_outline,
                    validator: AppValidator.validatePassword,
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
                    textEditingController: confirmPasswordSignUpController,
                    isPassword: true,
                    hasBorder: true,
                    hintText: "***************",
                    prefixIcon: Icons.lock_outline,
                    validator: AppValidator.validatePassword,
                  ),

                  SizedBox(height: 30.h),

                  /// Sign Up Button
                  CustomIconBtn(
                    isLoading: emailPasswordAuthProvider.isLoading,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        /// email sign up functionality
                        emailPasswordAuthProvider
                            .signUpWithEmailPassword(
                              emailSignUpController.text.trim(),
                              passwordSignUpController.text.trim(),
                              userNameSignUpController.text.trim(),
                              context,
                            )
                            .then((value) async {
                              /// Save Auth Status in Hive
                              var box = Hive.box('userAuthStatusBox');
                              await box.put('userAuthStatus', true);

                              /// email details screen
                              GoRouter.of(
                                context,
                              ).pushReplacementNamed("bottomNav");

                              /// clear all controllers
                              clearAllControllers();
                            });
                      }
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
                    onTap: () async {
                      try {
                        /// Attempt Google Sign-In
                        await googleSignInProvider.signInWithGoogle(context);

                        /// Check if user is authenticated
                        if (FirebaseAuth.instance.currentUser != null) {
                          /// Save Auth Status in Hive
                          var box = Hive.box('userAuthStatusBox');
                          await box.put('userAuthStatus', true);

                          /// Navigate to bottom nav screen
                          GoRouter.of(
                            context,
                          ).pushReplacementNamed("bottomNav");
                        }
                      } catch (e) {
                        print("Google Sign-In Failed: $e");
                      }
                    },
                    btnTitle: "Sign Up with Google",
                    iconPath: "google",
                  ),

                  SizedBox(height: 12.h),

                  /// apple sign up btn
                  CustomOutlinedBtn(
                    isLoading: appleSignInProvider.isLoading,
                    onTap: () {
                      /// sign in with google functionality
                      appleSignInProvider.signInWithApple(context).then((
                        value,
                      ) async {
                        /// Save Auth Status in Hive
                        var box = Hive.box('userAuthStatusBox');
                        await box.put('userAuthStatus', true);

                        /// bottom nav screen
                        GoRouter.of(context).pushReplacementNamed("bottomNav");
                      });
                    },
                    btnTitle: "Sign Up with Apple",
                    iconPath: "apple",
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
      ),
    );
  }
}
