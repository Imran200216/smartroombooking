import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/features/book_now/presentation/screens/book_now_screen.dart';
import 'package:smartroombooking/features/bottom_nav/presentation/provider/bottom_nav_provider.dart';
import 'package:smartroombooking/features/bottom_nav/presentation/widgets/bottom_nav_icon.dart';
import 'package:smartroombooking/features/home/presentation/screens/home_screen.dart';
import 'package:smartroombooking/features/my_bookings/presentation/screens/my_booking_screen.dart';
import 'package:smartroombooking/features/profile/presentation/screens/profile_screen.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Consumer<BottomNavProvider>(
          builder: (context, provider, child) {
            return NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor: AppColors.whiteColor,
                indicatorColor: AppColors.primaryColor.withOpacity(0.2),
                labelTextStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Redhat",
                    color: AppColors.titleColor,
                  ),
                ),
              ),
              child: NavigationBar(
                height: 60.h,
                elevation: 0,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                // Always show labels
                selectedIndex: provider.selectedIndex,
                onDestinationSelected: (value) {
                  provider.updateIndex(value); // Update the index in provider
                },
                destinations: [
                  NavigationDestination(
                    selectedIcon: BottomNavIcon(svgIconPath: "home-filled"),
                    icon: BottomNavIcon(svgIconPath: "home-outlined"),
                    label: "Home",
                  ),
                  NavigationDestination(
                    selectedIcon: BottomNavIcon(
                      svgIconPath: "book-room-filled",
                    ),
                    icon: BottomNavIcon(svgIconPath: "book-room-outlined"),
                    label: "Book Now",
                  ),
                  NavigationDestination(
                    selectedIcon: BottomNavIcon(
                      svgIconPath: "my-booking-filled",
                    ),
                    icon: BottomNavIcon(svgIconPath: "my-booking-outlined"),
                    label: "My Bookings",
                  ),
                  NavigationDestination(
                    selectedIcon: BottomNavIcon(svgIconPath: "profile-filled"),
                    icon: BottomNavIcon(svgIconPath: "profile-outlined"),
                    label: "Profile",
                  ),
                ],
              ),
            );
          },
        ),
        body: Consumer<BottomNavProvider>(
          builder: (context, provider, child) {
            switch (provider.selectedIndex) {
              case 0:
                return HomeScreen();
              case 1:
                return BookNowScreen();
              case 2:
                return const MyBookingScreen();
              case 3:
                return const ProfileScreen();
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
