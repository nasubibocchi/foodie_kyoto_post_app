import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_provider.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/shop_information_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoogleMapPage extends HookConsumerWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  static const CameraPosition _kKyotoCity = CameraPosition(
    target: LatLng(35.01, 135.78),
    zoom: 14.4746,
  );

  static const addAShopKey = 'Add-a-shop';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(googleMapProvider);
    final shopList = ref.watch(googleMapProvider.select((s) => s.when(
        (_, shopList, __, ___) => shopList,
        creating: () => [],
        error: () => [])));

    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kKyotoCity,
          onMapCreated: (controller) {
            ref.read(googleMapProvider.notifier).onMapCreated(controller);
            ref.read(googleMapProvider.notifier).fetchShopsStream();
          },
          markers: Set<Marker>.of(shopList
              .map((e) => Marker(
                    markerId: MarkerId(e.shopId),
                    position: LatLng(e.latitude, e.longitude),
                    onTap: () {
                      ref
                          .read(googleMapProvider.notifier)
                          .setShowingShopInformation(true, shopList.indexOf(e));
                    },
                  ))
              .toList()),
          myLocationButtonEnabled: false,
        ),
        state.when(
          (_, shopList, isShowingShopInformation, infoPageController) {
            return isShowingShopInformation
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 360,
                        child: PageView.builder(
                            controller: infoPageController,
                            itemCount: shopList.length,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index) => ref
                                .read(googleMapProvider.notifier)
                                .onSwipeShopInfo(index),
                            itemBuilder: (context, int index) {
                              return ShopInformationWidget(
                                shop: shopList[index],
                                onTapClose: () => ref
                                    .read(googleMapProvider.notifier)
                                    .setShowingShopInformation(false, 0),
                              );
                            }),
                      ),
                    ))
                : const SizedBox();
          },
          creating: () => const Center(
            child: CircularProgressIndicator(color: AppColors.appGrey),
          ),
          error: () => const Card(
            child: Text(
              'ERROR',
              style: TextStyle(color: AppColors.appBlack),
            ),
          ),
        ),
      ]),
      floatingActionButton: state.when(
        (googleMapController, _, isShowingShopInformation, __) =>
            isShowingShopInformation
                ? const SizedBox()
                : FloatingActionButton.extended(
                    backgroundColor: AppColors.appPink,
                    onPressed: () =>
                        context.go('/${RouteNames.searchShopPage}'),
                    icon: const Icon(Icons.add,
                        color: AppColors.appBlack,
                        size: 16,
                        key: Key(addAShopKey)),
                    label: const Text(
                      'お店を追加',
                      style: TextStyle(color: AppColors.appBlack),
                    ),
                  ),
        creating: () => const SizedBox(),
        error: () => const SizedBox(),
      ),
    );
  }
}
