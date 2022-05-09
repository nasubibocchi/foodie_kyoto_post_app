import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/foodie_location_model.dart';
import 'package:foodie_kyoto_post_app/data/model/foodie_prediction_model.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
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
    test('when there is some shops hit', () async {
      when(googleMapsPlaces.autocomplete('body')).thenAnswer(
          (_) async => PlacesAutocompleteResponse(status: 'ok', predictions: [
                Prediction(description: 'a', placeId: '1'),
                Prediction(description: 'b', placeId: '2')
              ]));

      final result = await model.searchShopsByAutoComplete(body: 'body');

      expect(result, isA<Success<List<FoodiePredictionModel>>>());

      result.whenWithResult(
        (list) => expect(list.value.length, 2),
        (e) => expect(e, Exception('Unhendled part, could be anything')),
      );
    });
  });

  group('search detail by shop id', () {
    test('when there is shop detail to return', () async {
      const placeId = 'place_id_1';
      when(googleMapsPlaces.getDetailsByPlaceId(placeId)).thenAnswer((_) async {
        return PlacesDetailsResponse(
            status: 'ok',
            result: PlaceDetails(
                name: 'name',
                placeId: placeId,
                geometry: Geometry(location: Location(lat: 50.0, lng: 135.0))),
            htmlAttributions: ['html_attributions']);
      });

      final model = container.read(placesDataSourceProvider);
      final result = await model.searchShopDetailByPlaceId(placeId: placeId);

      expect(result, isA<Success<FoodieLocationModel?>>());

      result.whenWithResult(
        (foodieLocation) => expect(foodieLocation.value?.latitude, 50.0),
        (e) => expect(e, Exception('Unhendled part, could be anything')),
      );
    });
  });
}
