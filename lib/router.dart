import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_page.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_page.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_page.dart';
import 'package:foodie_kyoto_post_app/ui/pages/search_shop_page/search_shop_page.dart';
import 'package:foodie_kyoto_post_app/ui/pages/shop_detail_page/shop_detail_page.dart';
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
              path: RouteNames.postShopPage,
              pageBuilder: (context, state) => MaterialPage(
                  child: PostShopPage(shopId: state.extra as String)),
            ),
            GoRoute(
              path: RouteNames.postMenuPage,
              pageBuilder: (context, state) => MaterialPage(
                  child: PostMenuPage(shopId: state.extra as String)),
            ),
            GoRoute(
              path: RouteNames.shopDetailPage,
              pageBuilder: (context, state) {
                final Map<String, Object?> params =
                    state.extra! as Map<String, Object?>;
                final Shop shop = params['shop'] as Shop;

                return MaterialPage(child: ShopDetailPage(shop: shop));
              },
              routes: [
                GoRoute(
                  path: RouteNames.postMenuPage,
                  pageBuilder: (context, state) {
                    final Map<String, Object?> params =
                        state.extra! as Map<String, Object?>;

                    final Shop shop = params['shop'] as Shop;
                    final Menu? menu = params['menu'] as Menu?;

                    return MaterialPage(
                        child: PostMenuPage(shopId: shop.shopId, menu: menu));
                  },
                ),
              ],
            ),
          ]),
    ]));
