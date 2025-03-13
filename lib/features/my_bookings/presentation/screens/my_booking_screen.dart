import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smartroombooking/commons/provider/internet_checker_provider.dart';
import 'package:smartroombooking/commons/provider/my_smart_room_bookings_provider.dart';
import 'package:smartroombooking/commons/widgets/custom_not_found_content.dart';
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
                child: Consumer2<
                  MySmartRoomBookingsProvider,
                  InternetCheckerProvider
                >(
                  builder: (
                    context,
                    mySmartRoomBookingsProvider,
                    internetCheckerProvider,
                    child,
                  ) {
                    /// no internet connection
                    if (!internetCheckerProvider.isNetworkConnected) {
                      return CustomNotFoundContent(
                        imagePath: "assets/icons/no-internet-connection.svg",
                        imageHeight: 160.h,
                        imageWidth: 160.w,
                        notFoundContentDescription: "No Internet Connection.",
                      );
                    }

                    /// shimmer effect
                    if (mySmartRoomBookingsProvider.isLoading) {
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

                    /// my smart room is empty
                    if (mySmartRoomBookingsProvider.bookings.isEmpty) {
                      return CustomNotFoundContent(
                        imagePath: "assets/img/svg/no-bookings-found.svg",
                        notFoundContentDescription: "No bookings found.",
                      );
                    }

                    /// my booking list view
                    return ListView.separated(
                      itemCount: mySmartRoomBookingsProvider.bookings.length,
                      separatorBuilder:
                          (context, index) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        var booking =
                            mySmartRoomBookingsProvider.bookings[index];
                        return CustomMySmartRoomBookingCard(
                          onTap: () {
                            /// MySmartRoomBookingsDescriptionScreen
                            GoRouter.of(context).pushNamed(
                              "mySmartRoomBookingsDescriptionScreen",
                              pathParameters: {
                                "userName": booking['userName'],
                                "bookingDate":
                                    (booking['bookingDate'] as Timestamp)
                                        .toDate()
                                        .toIso8601String(),
                                "roomNumber": booking['roomNumber'],
                                "bookingPeriods": booking['bookingTimePeriods']
                                    .join(','),
                              },
                            );
                          },
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
