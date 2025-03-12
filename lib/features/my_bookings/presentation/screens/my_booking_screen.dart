import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smartroombooking/commons/provider/my_smart_room_bookings_provider.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/features/my_bookings/presentation/widgets/custom_my_smart_room_booking_card.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ensure the method runs after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MySmartRoomBookingsProvider>(
        context,
        listen: false,
      ).listenToBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Smart Room Bookings",
                style: TextStyle(
                  fontFamily: "Redhat",
                  fontSize: 14.sp,
                  color: AppColors.titleColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: Consumer<MySmartRoomBookingsProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      /// shimmer effect
                      return Skeletonizer(
                        enabled: true,
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: 10,
                          separatorBuilder:
                              (context, index) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            return CustomMySmartRoomBookingCard(
                              personName: "Loading...",
                              roomNo: "###",
                            );
                          },
                        ),
                      );
                    }

                    if (provider.bookings.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/img/svg/no-bookings-found.svg",
                              height: 240.h,
                              width: 240.w,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "No bookings found.",
                              style: TextStyle(
                                fontFamily: "Redhat",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyDarkerColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: provider.bookings.length,
                      separatorBuilder:
                          (context, index) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        var booking = provider.bookings[index];
                        return CustomMySmartRoomBookingCard(
                          personName: booking['userName'],
                          roomNo: booking['roomNumber'],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
