import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_provider.dart';
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
        (googleMapController, shopList) => shopList,
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
                  position: LatLng(e.latitude, e.longitude)))
              .toList()),
          myLocationButtonEnabled: true,
        ),
        state.when(
          (_, __) => const SizedBox(),
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
        (googleMapController, _) => Padding(
          padding: const EdgeInsets.only(right: 64),
          child: FloatingActionButton(
            onPressed: () => context.go('/${RouteNames.searchShopPage}'),
            child: const Icon(Icons.add, key: Key(addAShopKey)),
          ),
        ),
        creating: () => const SizedBox(),
        error: () => const SizedBox(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
