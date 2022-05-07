import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/app_config.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/entity/foodie_prediction.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/places_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/search_shop_page/search_shop_controller.dart';
import 'package:foodie_kyoto_post_app/ui/pages/search_shop_page/search_shop_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_shop_controller_test.mocks.dart';

@GenerateMocks([PlacesUseCase])
void main() {
  final placesUseCase = MockPlacesUseCase();
  final container = ProviderContainer(overrides: [
    searchShopProvider.overrideWithProvider(
        StateNotifierProvider<SearchShopController, SearchShopState>(
            (ref) => SearchShopController(placesUseCase))),
  ]);

  final data = [
    FoodiePrediction(description: 'a', placeId: 'string1'),
    FoodiePrediction(description: 'b', placeId: 'string2'),
  ];

  appConfig = AppConfig(placesApiKey: 'placesApiKey');

  final model = container.read(searchShopProvider.notifier);

  group('search shops', () {
    test('when there is some shops hit', () async {
      when(placesUseCase.searchShopsByAutoComplete(
              body: model.debugState.searchController.text))
          .thenAnswer((_) async => Success(data));

      await model.searchShops();

      expect(model.debugState.searchResultList!.length, 2);
      expect(model.debugState.searchResultList!.first.placeId, 'string1');
    });
  });

  group('on edit search text', () {
    test('input text', () {
      model.onEditSearchText('body');
      expect(model.debugState.searchText, 'body');
    });
  });
}
