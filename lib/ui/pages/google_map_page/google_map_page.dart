import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoogleMapPage extends HookConsumerWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(googleMapProvider);

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: ref.read(googleMapProvider.notifier).onMapCreated,
      ),
      floatingActionButton: state.when(
          (googleMapController) => FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
          creating: () => const SizedBox()),
    );
  }
}
