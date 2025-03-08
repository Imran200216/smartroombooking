import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smartroombooking/commons/provider/date_picker_provider.dart';
import 'package:smartroombooking/commons/provider/muti_selection_chip_provider.dart';
import 'package:smartroombooking/config/default_firebase_options.dart';
import 'package:smartroombooking/core/router/app_router.dart';
import 'package:smartroombooking/core/service/notification_service.dart';
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
import 'package:timezone/data/latest.dart' as tz show initializeTimeZones;
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// safe area bg color
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: AppColors.safeAreaColor),
  );

  /// env file
  await dotenv.load(fileName: ".env");

  /// Detect the environment (default to `prod` if not set)
  const String environment = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'prod',
  );

  /// Load the correct environment file
  await dotenv.load(fileName: environment == "dev" ? ".env" : ".env");

  /// Firebase Initialization (Prevent Duplicate Initialization)
  try {
    await Firebase.initializeApp(
      name: environment,
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }

  /// hive initialization
  await Hive.initFlutter();

  /// on boarding status box
  await Hive.openBox('userGetStartedStatusBox');

  /// auth status box
  await Hive.openBox('userAuthStatusBox');

  /// Initialize Timezone
  tz.initializeTimeZones();

  /// notification service
  NotificationService.init();

  runApp(MyApp(environment: environment));
}

class MyApp extends StatelessWidget {
  final String environment;

  const MyApp({super.key, required this.environment});

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
                title: 'Smart Room Booking [$environment]',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: AppColors.primaryColor,
                  ),
                  fontFamily: "Rehat",
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
