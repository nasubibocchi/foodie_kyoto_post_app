import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop_detail.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/places_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/string_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_controller.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_shop_controller_test.mocks.dart';

@GenerateMocks([ShopUseCase, PlacesUseCase, StringUseCase, XFile, ImagePicker])
void main() {
  final _shopUseCase = MockShopUseCase();
  final _placesUseCase = MockPlacesUseCase();
  final _stringUseCase = MockStringUseCase();
  final _picker = MockImagePicker();

  final container = ProviderContainer(overrides: [
    postShopProvider.overrideWithProvider(StateNotifierProvider.family
        .autoDispose<PostShopController, PostShopState, String>(
            (ref, _shopId) => PostShopController(
                _shopUseCase, _placesUseCase, _stringUseCase, _shopId))),
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

      model.debugState.when((shop, commentController, comment, images,
          selectedServiceTags, selectedAreaTags, selectedFoodTags) {
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
              selectedAreaTags, selectedFoodTags) {},
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

      model.debugState.when((shop, commentController, comment, images,
          selectedServiceTags, selectedAreaTags, selectedFoodTags) async {
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
      model.debugState.when((shop, commentController, comment, images,
          selectedServiceTags, selectedAreaTags, selectedFoodTags) {
        expect(shop?.comment, 'comment');
        expect(comment, 'modified comment');
      }, loading: () {}, error: () {});
    });
  });

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/image_picker');
    channel.setMockMethodCallHandler((methodCall) async {
      if (methodCall.method == 'pickMultiImage') {
        return [MockXFile(), MockXFile()];
      }
      if (methodCall.method == 'pickImage') {
        return MockXFile();
      }
    });
  });

  group(
    'selectImages',
    () {
      test(
        'with selected xFiles',
        () async {
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

          when(_picker.pickMultiImage()).thenAnswer((_) async {
            return [MockXFile(), MockXFile()];
          });

          await model.selectImages();

          model.debugState.when((shop, commentController, comment, images,
              selectedServiceTags, selectedAreaTags, selectedFoodTags) {
            expect(images.length, 2);
            expect(images.first.path, '');
          }, loading: () {}, error: () {});
        },
        skip: true,
      );

      group(
        'changeImage',
        () {
          test('with selected xFiles', () async {
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

            model.debugState.when((shop, commentController, comment, images,
                selectedServiceTags, selectedAreaTags, selectedFoodTags) {
              expect(images.first.path, MockXFile().path);
            }, loading: () {}, error: () {});

            when(_picker.pickImage()).thenAnswer((_) async {
              return MockXFile();
            });

            await model.changeImage(0);

            model.debugState.when((shop, commentController, comment, images,
                selectedServiceTags, selectedAreaTags, selectedFoodTags) {
              expect(images.length, 1);
              expect(images.first.path, 'path2');
            }, loading: () {}, error: () {});
          });
        },
        skip: true,
      );

      group('add and remove serviceTag', () {
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

          model.debugState.when((shop, commentController, comment, images,
              selectedServiceTags, selectedAreaTags, selectedFoodTags) {
            expect(selectedServiceTags.length, 0);
            expect(selectedServiceTags, []);
          }, loading: () {}, error: () {});

          model.addServiceTag(1);

          model.debugState.when((shop, commentController, comment, images,
              selectedServiceTags, selectedAreaTags, selectedFoodTags) {
            expect(selectedServiceTags.length, 1);
            expect(selectedServiceTags, [1]);
          }, loading: () {}, error: () {});

          model.removeServiceTag(1);

          model.debugState.when((shop, commentController, comment, images,
              selectedServiceTags, selectedAreaTags, selectedFoodTags) {
            expect(selectedServiceTags.length, 0);
            expect(selectedServiceTags, []);
          }, loading: () {}, error: () {});

          model.removeServiceTag(1);

          model.debugState.when((shop, commentController, comment, images,
              selectedServiceTags, selectedAreaTags, selectedFoodTags) {
            expect(selectedServiceTags.length, 0);
            expect(selectedServiceTags, []);
          }, loading: () {}, error: () {});
        });
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

        model.debugState.when((shop, commentController, comment, images,
            selectedServiceTags, selectedAreaTags, selectedFoodTags) {
          expect(selectedAreaTags.length, 0);
          expect(selectedAreaTags, []);
        }, loading: () {}, error: () {});

        model.addAreaTag(1);

        model.debugState.when((shop, commentController, comment, images,
            selectedServiceTags, selectedAreaTags, selectedFoodTags) {
          expect(selectedAreaTags.length, 1);
          expect(selectedAreaTags, [1]);
        }, loading: () {}, error: () {});

        model.removeAreaTag(1);

        model.debugState.when((shop, commentController, comment, images,
            selectedServiceTags, selectedAreaTags, selectedFoodTags) {
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

        model.debugState.when((shop, commentController, comment, images,
            selectedServiceTags, selectedAreaTags, selectedFoodTags) {
          expect(selectedFoodTags.length, 0);
          expect(selectedFoodTags, []);
        }, loading: () {}, error: () {});

        model.addFoodTag(1);

        model.debugState.when((shop, commentController, comment, images,
            selectedServiceTags, selectedAreaTags, selectedFoodTags) {
          expect(selectedFoodTags.length, 1);
          expect(selectedFoodTags, [1]);
        }, loading: () {}, error: () {});

        model.removeFoodTag(1);

        model.debugState.when((shop, commentController, comment, images,
            selectedServiceTags, selectedAreaTags, selectedFoodTags) {
          expect(selectedFoodTags.length, 0);
          expect(selectedFoodTags, []);
        }, loading: () {}, error: () {});
      });
    },
    skip: true,
  );
}
