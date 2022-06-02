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
        (_, shopList, __) => shopList,
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
                          .setShowingShopInformation(true);
                    },
                  ))
              .toList()),
          myLocationButtonEnabled: false,
        ),
        state.when(
          (_, shopList, isShowingShopInformation) {
            return isShowingShopInformation
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 360,
                        child: PageView.builder(
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
                                    .setShowingShopInformation(false),
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
        (googleMapController, _, isShowingShopInformation) =>
            isShowingShopInformation
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 64),
                    child: FloatingActionButton(
                      onPressed: () =>
                          context.go('/${RouteNames.searchShopPage}'),
                      child: const Icon(Icons.add, key: Key(addAShopKey)),
                    ),
                  ),
        creating: () => const SizedBox(),
        error: () => const SizedBox(),
      ),
    );
  }
}
