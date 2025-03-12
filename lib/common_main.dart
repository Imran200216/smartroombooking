import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartroombooking/commons/provider/date_picker_provider.dart';
import 'package:smartroombooking/commons/provider/muti_selection_chip_provider.dart';
import 'package:smartroombooking/commons/provider/my_smart_room_bookings_provider.dart';
import 'package:smartroombooking/core/router/app_router.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/features/auth/presentation/provider/apple_sign_in_provider.dart';
import 'package:smartroombooking/features/auth/presentation/provider/email_password_auth_provider.dart';
import 'package:smartroombooking/features/auth/presentation/provider/google_sign_in_provider.dart';
import 'package:smartroombooking/features/auth/presentation/provider/user_role_provider.dart';
import 'package:smartroombooking/features/bottom_nav/presentation/provider/bottom_nav_provider.dart';
import 'package:smartroombooking/features/fourth_year/presentation/provider/fourth_year_smart_room_booking_provider.dart';
import 'package:smartroombooking/features/notification/presentation/provider/notification_provider.dart';
import 'package:smartroombooking/features/on_boarding/presentation/provider/on_boarding_provider.dart';
import 'package:smartroombooking/features/second_year/presentation/provider/second_year_smart_room_booking_provider.dart';
import 'package:smartroombooking/features/third_year/presentation/provider/third_year_smart_room_booking_provider.dart';
import 'package:smartroombooking/features/user_type/presentation/provider/user_type_provider.dart';
import 'package:toastification/toastification.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// on boarding provider
        ChangeNotifierProvider(create: (context) => OnBoardingProvider()),

        /// user type provider
        ChangeNotifierProvider(create: (context) => UserTypeProvider()),

        /// user role provider
        ChangeNotifierProvider(create: (context) => UserRoleProvider()),

        /// bottom nav provider
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),

        /// notification provider
        ChangeNotifierProvider(create: (context) => NotificationProvider()),

        /// multi selection chip provider
        ChangeNotifierProvider(
          create: (context) => MultiSelectionChipProvider(),
        ),

        /// google auth provider
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),

        /// email auth provider
        ChangeNotifierProvider(
          create: (context) => EmailPasswordAuthProvider(),
        ),

        /// apple sign in provider
        ChangeNotifierProvider(create: (context) => AppleSignInProvider()),

        /// date picker provider
        ChangeNotifierProvider(create: (context) => DatePickerProvider()),

        /// second year book room provider
        ChangeNotifierProvider(
          create: (context) => SecondYearSmartRoomBookingProvider(),
        ),

        /// Third year book room provider
        ChangeNotifierProvider(
          create: (context) => ThirdYearSmartRoomBookingProvider(),
        ),

        /// Fourth year book room provider
        ChangeNotifierProvider(
          create: (context) => FourthYearSmartRoomBookingProvider(),
        ),

        /// my smart room booking provider
        ChangeNotifierProvider(
          create: (context) => MySmartRoomBookingsProvider(),
        ),
      ],
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return ToastificationWrapper(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Smart Room Booking',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: AppColors.primaryColor,
                  ),
                  fontFamily: "Redhat",
                ),
                routerConfig: appRouter,
              ),
            );
          },
        );
      },
    );
  }
}
