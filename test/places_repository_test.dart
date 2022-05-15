import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/foodie_prediction_model.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/model/shop_detail_model.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/places_data_source.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/places_repository_impl.dart';
import 'package:foodie_kyoto_post_app/domain/entity/foodie_prediction.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop_detail.dart';
import 'package:foodie_kyoto_post_app/domain/repository/places_repository.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'places_repository_test.mocks.dart';

@GenerateMocks([PlacesDataSource])
void main() {
  final placesDataSource = MockPlacesDataSource();
  final container = ProviderContainer(overrides: [
    placesRepositoryProvider.overrideWithProvider(Provider<PlacesRepository>(
        (ref) => PlacesRepositoryImpl(dataSource: placesDataSource))),
  ]);

  final data = [
    {
      'description': 'a',
      'place_id': 'string1',
    },
    {
      'description': 'b',
      'place_id': 'string2',
    }
  ];

  final model = container.read(placesRepositoryProvider);

  group('initialize google places api', () {
    test('with valid api key', () {
      late GoogleMapsPlaces places;
      when(placesDataSource.initGooglePlaces(apiKey: 'apiKey')).thenAnswer((_) {
        places = GoogleMapsPlaces(apiKey: 'apiKey');
      });

      model.initGooglePlaces(apiKey: 'apiKey');

      expect(places, isA<GoogleMapsPlaces>());
    });
  });

  group('search shop', () {
    test('when there is some shops hit', () async {
      when(placesDataSource.searchShopsByAutoComplete(body: 'body')).thenAnswer(
          (_) async => Success(
              data.map((e) => FoodiePredictionModel.fromJson(e)).toList()));

      final shopModelResult =
          await model.searchShopsByAutoComplete(body: 'body');

      expect(shopModelResult, isA<Success<List<FoodiePrediction>>>());

      shopModelResult.whenWithResult(
        (list) => expect(list.value.length, 2),
        (e) => expect(e, Exception('Unhandled part, could be anything')),
      );
    });
  });

  group('get shop detail by place id', () {
    test('when there is location to return', () async {
      const placeId = 'place_id_1';
      when(placesDataSource.searchShopDetailsByPlaceId(placeId: placeId))
          .thenAnswer((_) async {
        return Success(
            ShopDetailModel(name: 'shop1', latitude: 50.0, longitude: 135));
      });

      final model = container.read(placesRepositoryProvider);
      final result = await model.searchShopDetailsByPlaceId(placeId: placeId);

      expect(result, isA<Success<ShopDetail?>>());

      result.whenWithResult(
        (foodieLocation) => expect(foodieLocation.value?.latitude, 50.0),
        (e) => expect(e, Exception('Unhandled part, could be anything')),
      );
    });
  });
}
