import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smartroombooking/core/service/haptic_feedback_service.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/features/notification/presentation/provider/notification_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// provider
    final notificationProvider = Provider.of<NotificationProvider>(context);

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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// img
                SvgPicture.asset(
                  "assets/img/svg/push-notification.svg",
                  height: 230.h,
                  width: 230.w,
                  fit: BoxFit.cover,
                ),

                SizedBox(height: 30.h),

                /// title text
                Text(
                  textAlign: TextAlign.start,
                  "Stay Updated with SmartRoomBooking",
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
                  '''📢 Enable notifications to never miss important updates, messages, and alerts. Stay connected with real-time updates, reminders, and notifications tailored just for you!''',
                  style: TextStyle(
                    fontFamily: "Redhat",
                    fontWeight: FontWeight.w600,
                    color: AppColors.subTitleColor,
                    fontSize: 13.sp,
                  ),
                ),

                const Spacer(),

                /// notification list tile
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.subTitleColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ListTile(
                    trailing: Switch.adaptive(
                      value: notificationProvider.isNotificationEnabled,
                      activeColor: AppColors.primaryColor,
                      onChanged: (value) {
                        /// haptic feed back
                        HapticFeedbackUtilityService.mediumImpact();

                        /// toggle notification
                        notificationProvider.toggleNotification(value);
                      },
                    ),
                    leading: Icon(Icons.notifications),
                    title: Text("Allow Notification"),
                    titleTextStyle: TextStyle(
                      fontFamily: "Redhat",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
