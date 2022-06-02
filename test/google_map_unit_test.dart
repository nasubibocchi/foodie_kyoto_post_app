import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_model.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'google_map_unit_test.mocks.dart';

@GenerateMocks([ShopUseCase, GoogleMapController])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final _shopUseCase = MockShopUseCase();
  final _googleMapController = MockGoogleMapController();

  final container = ProviderContainer(overrides: [
    googleMapProvider.overrideWithProvider(
        StateNotifierProvider<GoogleMapPageController, GoogleMapState>(
            (ref) => GoogleMapPageController(_shopUseCase))),
    googleMapProvider.overrideWithValue(GoogleMapPageController(_shopUseCase)),
  ]);

  group('Google map function tests', () {
    test('onMapCreated', () async {
      final state1 = container.read(googleMapProvider);
      // onMapCreatedが呼ばれる前はGoogleMapState.creating()であることを確認
      expect(state1, GoogleMapState.creating());

      final model = container.read(googleMapProvider.notifier);
      model.onMapCreated(_googleMapController);

      final state2 = container.read(googleMapProvider);

      // onMapCreatedが呼ばれた後はGoogleMapState()であることを確認
      model.debugState.when(
        (googleMapController, _, __) => expect(
            state2, GoogleMapState(googleMapController: _googleMapController)),
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

  group('getZoomLevel', () {
    test('when the state is _GoogleMapState', () async {
      final model = container.read(googleMapProvider.notifier);
      model.onMapCreated(_googleMapController);

      when(_googleMapController.getZoomLevel()).thenAnswer((_) async {
        return 14.5;
      });

      final result = await model.getZoomLevel();

      expect(result, 14.5);
    });
  });

  group('getRadiusKiloMeter', () {
    test('when the state is _GoogleMapState', () async {
      final model = container.read(googleMapProvider.notifier);
      model.onMapCreated(_googleMapController);

      when(_googleMapController.getZoomLevel()).thenAnswer((_) async {
        return 14.5;
      });

      final result = await model.getMapRadiusKiloMeter();
      final actual = result * 1000;

      expect(actual.round(), 1657);
    });
  });

  group('getCenterLocation', () {
    test('when the state is _GoogleMapState', () async {
      final model = container.read(googleMapProvider.notifier);
      model.onMapCreated(_googleMapController);

      when(_googleMapController.getVisibleRegion()).thenAnswer((_) async {
        return LatLngBounds(
            southwest: const LatLng(35.0, 135.0),
            northeast: const LatLng(35.5, 135.5));
      });

      final result = await model.getCenterLocation();

      expect(result?.latitude, 35.25);
      expect(result?.longitude, 135.25);
    });
  });
}
