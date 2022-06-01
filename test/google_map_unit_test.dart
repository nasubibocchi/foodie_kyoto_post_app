import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_model.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';

import 'google_map_unit_test.mocks.dart';

@GenerateMocks([ShopUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final _shopUseCase = MockShopUseCase();

  final container = ProviderContainer(overrides: [
    googleMapProvider.overrideWithProvider(
        StateNotifierProvider<GoogleMapPageController, GoogleMapState>(
            (ref) => GoogleMapPageController(_shopUseCase))),
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
        (googleMapController, _) => expect(
            state2, GoogleMapState(googleMapController: googleMapController)),
        creating: () {
          // ignore: avoid_print
          print('test is not passed');
        },
        error: () {
          // ignore: avoid_print
          print('test is not passed');
        },
      );
    });
  });
}
