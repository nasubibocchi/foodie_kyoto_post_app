import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/places_data_source.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/model_data_source_impl/places_data_source_impl.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'places_data_source_test.mocks.dart';

@GenerateMocks([GoogleMapsPlaces])
void main() {
  final googleMapsPlaces = MockGoogleMapsPlaces();

  final container = ProviderContainer(overrides: [
    placesDataSourceProvider.overrideWithProvider(
        Provider<PlacesDataSource>((ref) => PlacesDataSourceImpl())),
  ]);

  final model = container.read(placesDataSourceProvider);
  model.places = googleMapsPlaces;

  group('initialize google places api', () {
    test('with valid api key', () {
      final state1 = model.places;
      // 一旦型確認だけ
      expect(state1, isA<GoogleMapsPlaces>());
    });
  });

  group('search shop', () {
    test('when there is a shop hit', () async {
      when(googleMapsPlaces.autocomplete('body')).thenAnswer(
          (_) async => PlacesAutocompleteResponse(status: 'ok', predictions: [
                Prediction(description: 'a', placeId: '1'),
                Prediction(description: 'b', placeId: '2')
              ]));

      final result = await model.searchShopsByAutoComplete(body: 'body');

      result.whenWithResult(
        (list) => expect(list.value.length, 2),
        (e) => expect(e, Exception('Unhendled part, could be anything')),
      );
    });
  });
}
