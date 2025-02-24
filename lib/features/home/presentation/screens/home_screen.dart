import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartroombooking/commons/widgets/custom_icon_btn.dart';
import 'package:smartroombooking/core/service/notification_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// college img
              Container(
                height: 140.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/jpg/college.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  children: [
                    /// scheduled notification
                    CustomIconBtn(
                      onTap: () {
                        /// schedule notification functionality
                        DateTime scheduleDate = DateTime.now().add(
                          Duration(seconds: 5),
                        );

                        NotificationService.scheduledNotification(
                          "HI Sai",
                          "Room 402 Smart Room is booked",
                          scheduleDate,
                        );
                      },
                      btnTitle: "Scheduled notification",
                      iconPath: "login",
                    ),

                    SizedBox(height: 20.h),

                    /// instant notification
                    CustomIconBtn(
                      onTap: () {
                        NotificationService.showInstantNotification(
                          "Hi Sai",
                          "Room 402 Instant notificatin",
                        );
                      },
                      btnTitle: "Instant notification",
                      iconPath: "login",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
