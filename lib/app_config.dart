import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

late AppConfig appConfig;

class AppConfig {
  AppConfig({required this.placesApiKey});

  String? placesApiKey;

  static Future<void> load() async {
    String? placesApiKey;
    const flavor = String.fromEnvironment('FLAVOR');

    if (flavor == 'dev') {
      placesApiKey = Platform.isAndroid
          ? dotenv.get('PLACES_API_KEY_Android_DEV')
          : dotenv.get('PLACES_API_KEY_iOS_DEV');
    } else {
      placesApiKey = Platform.isAndroid
          ? dotenv.get('PLACES_API_KEY_Android_PROD')
          : dotenv.get('PLACES_API_KEY_iOS_PROD');
    }

    appConfig = AppConfig(placesApiKey: placesApiKey);
  }
}
