import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

late AppConfig appConfig;

class AppConfig {
  AppConfig({required this.placesApiKey});

  String? placesApiKey;

  static Future<void> load() async {
    String? placesApiKey;

    if (Platform.isAndroid) {
      placesApiKey = kReleaseMode
          ? dotenv.get('PLACES_API_KEY_Android_PROD')
          : dotenv.get('PLACES_API_KEY_Android_DEV');
    } else {
      placesApiKey = kReleaseMode
          ? dotenv.get('PLACES_API_KEY_iOS_PROD')
          : dotenv.get('PLACES_API_KEY_iOS_DEV');
    }

    appConfig = AppConfig(placesApiKey: placesApiKey);
  }
}
