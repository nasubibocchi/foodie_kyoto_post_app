import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop_detail.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/places_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_controller.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_shop_controller_test.mocks.dart';

@GenerateMocks([ShopUseCase, PlacesUseCase])
void main() {
  final _shopUseCase = MockShopUseCase();
  final _placesUseCase = MockPlacesUseCase();

  final container = ProviderContainer(overrides: [
    postShopProvider.overrideWithProvider(StateNotifierProvider.family
        .autoDispose<PostShopController, PostShopState, String>(
            (ref, _shopId) =>
                PostShopController(_shopUseCase, _placesUseCase, _shopId))),
  ]);

  group('init shop state', () {
    const shopId = 'shop_id_1';

    test('when there is a shop to return', () async {
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(Shop(
            name: 'name',
            shopId: 'shop_id_1',
            latitude: 45.0,
            longitude: 135.0,
            comment: 'comment',
            images: [],
            tags: [],
            postUser: 'user1'));
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      model.debugState.when((shop, commentController, comment) {
        expect(shop?.shopId, 'shop_id_1');
        expect(shop?.name, 'name');
        expect(shop?.comment, 'comment');
      }, loading: () {}, error: () {});
    });

    test('when some errors happened', () async {
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Error(Exception('error'));
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      final state = model.debugState;

      model.debugState.when((shop, commentController, comment) {},
          loading: () {}, error: () {
        expect(state, PostShopState.error());
      });
    });

    // firestoreの既存データがない時は、places API の検索結果を表示するようにする。
    test('when there is no shop to return', () async {
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(null);
      });

      when(_placesUseCase.searchShopDetailsByPlaceId(placeId: shopId))
          .thenAnswer((realInvocation) async {
        return Success(
            ShopDetail(name: 'name', latitude: 135.0, longitude: 45.0));
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      final state = model.debugState;

      model.debugState.when((shop, commentController, comment) async {
        expect(shop?.name, 'name');
        expect(shop?.latitude, 135.0);
        expect(shop?.longitude, 45.0);

        expect(
          state,
          PostShopState(
              shop: shop,
              commentController: commentController,
              comment: comment),
        );
      }, loading: () {}, error: () {});
    });
  });

  // 'init shop state' がpassした状態で実行する
  group('edit comment', () {
    test('when input some comment', () async {
      const shopId = 'shop_id_1';
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(Shop(
            name: 'name',
            shopId: 'shop_id_1',
            latitude: 45.0,
            longitude: 135.0,
            comment: 'comment',
            images: [],
            tags: [],
            postUser: 'user1'));
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      model.editComment('modified comment');
      model.debugState.when((shop, commentController, comment) {
        expect(shop?.comment, 'modified comment');
        expect(comment, 'modified comment');
      }, loading: () {}, error: () {});
    });
  });
}
