import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartroombooking/core/router/app_router.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/features/on_boarding/presentation/provider/on_boarding_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// on boarding provider
        ChangeNotifierProvider(create: (context) => OnBoardingProvider()),
      ],
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Smart Room Booking',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.primaryColor,
                ),
                fontFamily: "Rehat",
              ),
              routerConfig: appRouter,
            );
          },
        );
      },
    );
  }
}
