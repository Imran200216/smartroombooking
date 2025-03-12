import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartroombooking/core/service/notification_service.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/firebase_options_prod.dart' as prod;
import 'package:timezone/data/latest.dart' as tz show initializeTimeZones;

import 'common_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// safe area color
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: AppColors.safeAreaColor),
  );

  /// load dot env
  await dotenv.load(fileName: ".env");

  /// firebase option initialization
  try {
    await Firebase.initializeApp(
      name: "Smart Room Booking Prod",
      options: prod.DefaultFirebaseOptions.currentPlatform,
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

  runApp(const MyApp());
}
