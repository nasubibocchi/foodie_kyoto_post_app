import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodie_kyoto_post_app/app_config.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_page.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_page.dart';
import 'package:foodie_kyoto_post_app/ui/pages/search_shop_page/search_shop_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load();
  await AppConfig.load().then((_) => runApp(ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _router = GoRouter(routes: <GoRoute>[
    GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            const MaterialPage(child: GoogleMapPage()),
        routes: [
          GoRoute(
              path: 'search_shop_page',
              pageBuilder: (context, state) =>
                  const MaterialPage(child: SearchShopPage()),
              routes: [
                GoRoute(
                  path: 'post_shop_page',
                  pageBuilder: (context, state) => MaterialPage(
                      child: PostShopPage(shopId: state.extra as String)),
                ),
              ]),
        ]),
  ]);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Foodie kyoto post app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
    );
  }
}
