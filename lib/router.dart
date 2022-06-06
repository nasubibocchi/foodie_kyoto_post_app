import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_page.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_page.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_page.dart';
import 'package:foodie_kyoto_post_app/ui/pages/search_shop_page/search_shop_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) => GoRouter(routes: <GoRoute>[
      GoRoute(
          path: RouteNames.homePage,
          pageBuilder: (context, state) =>
              const MaterialPage(child: GoogleMapPage()),
          routes: [
            GoRoute(
                path: RouteNames.searchShopPage,
                pageBuilder: (context, state) =>
                    const MaterialPage(child: SearchShopPage()),
                routes: [
                  GoRoute(
                    path: RouteNames.postShopPage,
                    pageBuilder: (context, state) => MaterialPage(
                        child: PostShopPage(shopId: state.extra as String)),
                  ),
                ]),
            GoRoute(
              path: RouteNames.postMenuPage,
              pageBuilder: (context, state) => MaterialPage(
                  child: PostMenuPage(shopId: state.extra as String)),
            ),
          ]),
    ]));
