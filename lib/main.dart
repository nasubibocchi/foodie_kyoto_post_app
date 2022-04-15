import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodie_kyoto_post_app/app_config.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load();
  await AppConfig.load()
      .then((_) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodie kyoto post app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GoogleMapPage(),
    );
  }
}
