import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop_detail.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/image_file_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/places_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_image_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_controller.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_shop_controller_test.mocks.dart';

@GenerateMocks([ShopUseCase, PlacesUseCase, ShopImageUseCase, ImageFileUseCase])
void main() {
  final _shopUseCase = MockShopUseCase();
  final _placesUseCase = MockPlacesUseCase();
  final _shopImageUseCase = MockShopImageUseCase();
  final _imageFileUseCase = MockImageFileUseCase();

  final container = ProviderContainer(overrides: [
    postShopProvider.overrideWithProvider(StateNotifierProvider.family
        .autoDispose<PostShopController, PostShopState, String>(
            (ref, _shopId) => PostShopController(_shopUseCase, _placesUseCase,
                _shopImageUseCase, _imageFileUseCase, _shopId))),
  ]);

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/path_provider_macos');
    channel.setMockMethodCallHandler((methodCall) async {
      if (methodCall.method == 'getTemporaryDirectory') {
        return 'temporary_path';
      }
    });
  });

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
            serviceTags: <int>[],
            areaTags: <int>[],
            foodTags: <int>[],
            postUser: 'user1'));
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      model.debugState.when((shop,
          commentController,
          comment,
          images,
          selectedServiceTags,
          selectedAreaTags,
          selectedFoodTags,
          postUserName) {
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

      model.debugState.when(
          (shop, commentController, comment, images, selectedServiceTags,
              selectedAreaTags, selectedFoodTags, postUserName) {},
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

      model.debugState.when((shop,
          commentController,
          comment,
          images,
          selectedServiceTags,
          selectedAreaTags,
          selectedFoodTags,
          postUserName) async {
        expect(shop?.name, 'name');
        expect(shop?.latitude, 135.0);
        expect(shop?.longitude, 45.0);

        expect(
          state,
          PostShopState(
              shop: shop,
              commentController: commentController,
              comment: comment,
              images: []),
        );
      }, loading: () {}, error: () {});
    });
  });

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
            serviceTags: <int>[],
            areaTags: <int>[],
            foodTags: <int>[],
            postUser: 'user1'));
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      model.editComment('modified comment');
      model.debugState.when((shop,
          commentController,
          comment,
          images,
          selectedServiceTags,
          selectedAreaTags,
          selectedFoodTags,
          postUserName) {
        expect(shop?.comment, 'comment');
        expect(comment, 'modified comment');
      }, loading: () {}, error: () {});
    });
  });

  group(
    'selectImages',
    () {
      test('with selected Files', () async {
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
              serviceTags: <int>[],
              areaTags: <int>[],
              foodTags: <int>[],
              postUser: 'user1'));
        });

        final model = container.read(postShopProvider(shopId).notifier);
        await model.initShopState();

        when(_imageFileUseCase.pickMultiImage()).thenAnswer((_) async {
          return Success([File('path1'), File('path2')]);
        });

        await model.selectImages();

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(images.length, 2);
          expect(images.first.path, '');
        }, loading: () {}, error: () {});
      });
    },
    skip: true,
  );

  group(
    'changeImage',
    () {
      test('with selected Files', () async {
        const shopId = 'shop_id_1';
        when(_shopUseCase.fetchShopByShopId(shopId: shopId))
            .thenAnswer((_) async {
          return Success(Shop(
              name: 'name',
              shopId: 'shop_id_1',
              latitude: 45.0,
              longitude: 135.0,
              comment: 'comment',
              images: ['path1'],
              serviceTags: <int>[],
              areaTags: <int>[],
              foodTags: <int>[],
              postUser: 'user1'));
        });

        final model = container.read(postShopProvider(shopId).notifier);
        await model.initShopState();

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(images.first.path, 'path1');
        }, loading: () {}, error: () {});

        when(_imageFileUseCase.pickImage()).thenAnswer((_) async {
          return Success(File('path1'));
        });

        await model.changeImage(0);

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(images.length, 1);
          expect(images.first.path, 'path2');
        }, loading: () {}, error: () {});
      });
    },
    skip: true,
  );

  group(
    'add and remove serviceTag',
    () {
      test('when _PostShopState', () async {
        const shopId = 'shop_id_1';
        when(_shopUseCase.fetchShopByShopId(shopId: shopId))
            .thenAnswer((_) async {
          return Success(Shop(
              name: 'name',
              shopId: 'shop_id_1',
              latitude: 45.0,
              longitude: 135.0,
              comment: 'comment',
              images: ['path1'],
              serviceTags: <int>[],
              areaTags: <int>[],
              foodTags: <int>[],
              postUser: 'user1'));
        });

        final model = container.read(postShopProvider(shopId).notifier);
        await model.initShopState();

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(selectedServiceTags.length, 0);
          expect(selectedServiceTags, []);
        }, loading: () {}, error: () {});

        model.addServiceTag(1);

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(selectedServiceTags.length, 1);
          expect(selectedServiceTags, [1]);
        }, loading: () {}, error: () {});

        model.removeServiceTag(1);

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(selectedServiceTags.length, 0);
          expect(selectedServiceTags, []);
        }, loading: () {}, error: () {});

        model.removeServiceTag(1);

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(selectedServiceTags.length, 0);
          expect(selectedServiceTags, []);
        }, loading: () {}, error: () {});
      });
    },
    skip: true,
  );

  group(
    'add or remove area tag',
    () {
      test('when _PostShopState', () async {
        const shopId = 'shop_id_1';
        when(_shopUseCase.fetchShopByShopId(shopId: shopId))
            .thenAnswer((_) async {
          return Success(Shop(
              name: 'name',
              shopId: 'shop_id_1',
              latitude: 45.0,
              longitude: 135.0,
              comment: 'comment',
              images: ['path1'],
              serviceTags: <int>[],
              areaTags: <int>[],
              foodTags: <int>[],
              postUser: 'user1'));
        });

        final model = container.read(postShopProvider(shopId).notifier);
        await model.initShopState();

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(selectedAreaTags.length, 0);
          expect(selectedAreaTags, []);
        }, loading: () {}, error: () {});

        model.addAreaTag(1);

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(selectedAreaTags.length, 1);
          expect(selectedAreaTags, [1]);
        }, loading: () {}, error: () {});

        model.removeAreaTag(1);

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(selectedAreaTags.length, 0);
          expect(selectedAreaTags, []);
        }, loading: () {}, error: () {});
      });
    },
    skip: true,
  );

  group(
    'add or remove food tag',
    () {
      test('when _PostShopState', () async {
        const shopId = 'shop_id_1';
        when(_shopUseCase.fetchShopByShopId(shopId: shopId))
            .thenAnswer((_) async {
          return Success(Shop(
              name: 'name',
              shopId: 'shop_id_1',
              latitude: 45.0,
              longitude: 135.0,
              comment: 'comment',
              images: ['path1'],
              serviceTags: <int>[],
              areaTags: <int>[],
              foodTags: <int>[],
              postUser: 'user1'));
        });

        final model = container.read(postShopProvider(shopId).notifier);
        await model.initShopState();

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(selectedFoodTags.length, 0);
          expect(selectedFoodTags, []);
        }, loading: () {}, error: () {});

        model.addFoodTag(1);

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(selectedFoodTags.length, 1);
          expect(selectedFoodTags, [1]);
        }, loading: () {}, error: () {});

        model.removeFoodTag(1);

        model.debugState.when((shop,
            commentController,
            comment,
            images,
            selectedServiceTags,
            selectedAreaTags,
            selectedFoodTags,
            postUserName) {
          expect(selectedFoodTags.length, 0);
          expect(selectedFoodTags, []);
        }, loading: () {}, error: () {});
      });
    },
    skip: true,
  );
}
