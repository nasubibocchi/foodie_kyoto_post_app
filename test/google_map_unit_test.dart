import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_model.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(overrides: [
    googleMapProvider.overrideWithProvider(
        StateNotifierProvider<GoogleMapPageController, GoogleMapState>(
            (ref) => GoogleMapPageController())),
    // googleMapProvider.overrideWithValue(GoogleMapPageController()),
  ]);

  group('Google map function tests', () {
    test('onMapCreated', () async {
      GoogleMapController? controller;

      final state1 = container.read(googleMapProvider);
      // onMapCreatedが呼ばれる前はGoogleMapState.creating()であることを確認
      expect(state1, GoogleMapState.creating());

      final model = container.read(googleMapProvider.notifier);
      model.onMapCreated(controller);

      final state2 = container.read(googleMapProvider);

      // onMapCreatedが呼ばれた後はGoogleMapState()であることを確認
      model.debugState.when(
          (googleMapController) => expect(
              state2, GoogleMapState(googleMapController: googleMapController)),
          creating: () => expect(state2, GoogleMapState.creating()));
    });
  });
}
