import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // Get environment type
    const environment = String.fromEnvironment('ENV', defaultValue: 'prod');

    if (environment == "dev") {
      if (Platform.isAndroid) {
        return FirebaseOptions(
          apiKey: dotenv.env['DEV_ANDROID_API_KEY']!,
          appId: dotenv.env['DEV_ANDROID_APP_ID']!,
          messagingSenderId: dotenv.env['DEV_ANDROID_SENDER_ID']!,
          projectId: dotenv.env['DEV_PROJECT_ID']!,
          storageBucket: dotenv.env['DEV_STORAGE_BUCKET']!,
        );
      } else if (Platform.isIOS) {
        return FirebaseOptions(
          apiKey: dotenv.env['DEV_IOS_API_KEY']!,
          appId: dotenv.env['DEV_IOS_APP_ID']!,
          messagingSenderId: dotenv.env['DEV_IOS_SENDER_ID']!,
          projectId: dotenv.env['DEV_PROJECT_ID']!,
          storageBucket: dotenv.env['DEV_STORAGE_BUCKET']!,
          iosClientId: dotenv.env['DEV_IOS_CLIENT_ID']!,
          androidClientId: dotenv.env['DEV_ANDROID_CLIENT_ID']!,
        );
      }
    } else {
      if (Platform.isAndroid) {
        return FirebaseOptions(
          apiKey: dotenv.env['PROD_ANDROID_API_KEY']!,
          appId: dotenv.env['PROD_ANDROID_APP_ID']!,
          messagingSenderId: dotenv.env['PROD_ANDROID_SENDER_ID']!,
          projectId: dotenv.env['PROD_PROJECT_ID']!,
          storageBucket: dotenv.env['PROD_STORAGE_BUCKET']!,
        );
      } else if (Platform.isIOS) {
        return FirebaseOptions(
          apiKey: dotenv.env['PROD_IOS_API_KEY']!,
          appId: dotenv.env['PROD_IOS_APP_ID']!,
          messagingSenderId: dotenv.env['PROD_IOS_SENDER_ID']!,
          projectId: dotenv.env['PROD_PROJECT_ID']!,
          storageBucket: dotenv.env['PROD_STORAGE_BUCKET']!,
          iosClientId: dotenv.env['PROD_IOS_CLIENT_ID']!,
          androidClientId: dotenv.env['PROD_ANDROID_CLIENT_ID']!,
        );
      }
    }

    throw UnsupportedError("This platform is not supported");
  }
}
