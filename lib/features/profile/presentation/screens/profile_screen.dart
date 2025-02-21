import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smartroombooking/core/service/url_launcher_service.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/features/profile/presentation/widgets/custom_profile_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// person placeholder
    final String personPlaceHolder =
        "https://i.pinimg.com/736x/fb/8f/3e/fb8f3e83f9146e6b6a805a535f665dd7.jpg";

    /// portfolio link
    final String imranPortfolio = "https://linktr.ee/Imran_B";
    final String saiKumarShettyPortfolio = "https://www.saikumarenishetty.site";

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// profile image
              Container(
                height: 80.h,
                width: 80.h,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Image.asset(
                          "assets/img/jpg/person-placeholder.jpeg",
                          // Path to placeholder image
                          fit: BoxFit.cover,
                        ),
                    errorWidget:
                        (context, url, error) => Image.asset(
                          "assets/img/jpg/person-placeholder.jpeg",
                          // Path to error image
                          fit: BoxFit.cover,
                        ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              /// title text
              Text(
                textAlign: TextAlign.start,
                "Imran B",
                style: TextStyle(
                  fontFamily: "Redhat",
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleColor,
                  fontSize: 16.sp,
                ),
              ),

              SizedBox(height: 2.h),

              /// sub title color
              Text(
                textAlign: TextAlign.center,
                "imranbabuji162002@gmail.com",
                style: TextStyle(
                  fontFamily: "Redhat",
                  fontWeight: FontWeight.w600,
                  color: AppColors.subTitleColor,
                  fontSize: 13.sp,
                ),
              ),

              SizedBox(height: 20.h),

              /// about app
              CustomProfileListTile(
                onTap: () {},
                leadingIcon: Icons.app_registration,
                listTileTitle: "About app",
              ),

              SizedBox(height: 8.h),

              /// about app
              CustomProfileListTile(
                onTap: () {},
                leadingIcon: Icons.share,
                listTileTitle: "Share app",
              ),

              SizedBox(height: 8.h),

              /// notification
              CustomProfileListTile(
                onTap: () {
                  /// notification screen
                  GoRouter.of(context).pushNamed("notificationScreen");
                },
                leadingIcon: Icons.notifications,
                listTileTitle: "Notification",
              ),

              SizedBox(height: 8.h),

              /// logout
              CustomProfileListTile(
                onTap: () {},
                leadingIcon: Icons.logout,
                listTileTitle: "Logout",
              ),

              const Spacer(),

              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.primaryColor,
                          size: 16.h,
                        ),
                      ),
                      TextSpan(
                        text: ' Made with love by ',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.greyDarkerColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Redhat",
                        ),
                      ),
                      TextSpan(
                        text: 'Imran B',
                        style: TextStyle(
                          fontFamily: "Redhat",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.linkColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.linkColor,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () async {
                                /// imran portfolio
                                UrlLauncherService.launchUrlInBrowser(
                                  imranPortfolio,
                                );
                              },
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Sai Kumar Enishetty',
                        style: TextStyle(
                          fontFamily: "Redhat",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.linkColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.linkColor,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () async {
                                /// sai portfolio
                                UrlLauncherService.launchUrlInBrowser(
                                  saiKumarShettyPortfolio,
                                );
                              },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
