import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/constants/post_users_data.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop_detail.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/image_file_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/path_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/places_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_image_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_controller.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_shop_controller_test.mocks.dart';

@GenerateMocks([
  ShopUseCase,
  PlacesUseCase,
  ShopImageUseCase,
  ImageFileUseCase,
  PathUseCase,
  http.Client,
  Directory,
])
void main() {
  final _shopUseCase = MockShopUseCase();
  final _placesUseCase = MockPlacesUseCase();
  final _shopImageUseCase = MockShopImageUseCase();
  final _imageFileUseCase = MockImageFileUseCase();
  final _pathUseCase = MockPathUseCase();
  final _client = MockClient();

  final container = ProviderContainer(overrides: [
    postShopProvider.overrideWithProvider(StateNotifierProvider.family
        .autoDispose<PostShopController, PostShopState, String>(
            (ref, _shopId) => PostShopController(_shopUseCase, _placesUseCase,
                _shopImageUseCase, _imageFileUseCase, _pathUseCase, _shopId))),
  ]);

  const imagePath = 'https://path1';
  final shop = Shop(
      name: 'name',
      shopId: 'shop_id_1',
      latitude: 45.0,
      longitude: 135.0,
      comment: 'comment',
      images: [],
      serviceTags: <int>[],
      areaTags: <int>[],
      foodTags: <int>[],
      postUser: 'user1',
      price: 3000);

  final shopWithImage = Shop(
      name: 'name',
      shopId: 'shop_id_1',
      latitude: 45.0,
      longitude: 135.0,
      comment: 'comment',
      images: [imagePath],
      serviceTags: <int>[],
      areaTags: <int>[],
      foodTags: <int>[],
      postUser: 'user1',
      price: 3000);

  group('init shop state', () {
    const shopId = 'shop_id_1';

    test('when there is a shop to return', () async {
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(shop);
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      model.debugState.when((shop, _, __, ___, ____, _____, ______, _______,
          ________, _________) {
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
          (shop, _, __, ___, ____, _____, ______, _______, ________,
              _________) {},
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

      model.debugState.when((shop, commentController, comment, _, __, ___, ____,
          _____, ______, _______) async {
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

  group(
    'urlToFile',
    () {
      test('there is File to return', () async {
        const shopId = 'shop_id_1';

        final url = Uri.parse(imagePath);

        when(_shopUseCase.fetchShopByShopId(shopId: shopId))
            .thenAnswer((_) async {
          return Success(shopWithImage);
        });

        when(_pathUseCase.getTempDirectory()).thenAnswer((_) async {
          return Success(MockDirectory());
        });

        when(_client.get(url)).thenAnswer((_) async {
          return http.Response(imagePath, 200);
        });

        final model = container.read(postShopProvider(shopId).notifier);
        final result = await model.urlToFile(imagePath, 'fileName');

        expect(result, isA<File>());
      });
    },
    skip: true,
  );

  group('edit comment', () {
    test('when input some comment', () async {
      const shopId = 'shop_id_1';
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(shop);
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      model.editComment('modified comment');
      model.debugState.when(
          (shop, _, comment, __, ___, ____, _____, ______, _______, ________) {
        expect(shop?.comment, 'comment');
        expect(comment, 'modified comment');
      }, loading: () {}, error: () {});
    });
  });

  group('selectImages', () {
    test('with selected Files', () async {
      const shopId = 'shop_id_1';
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(shop);
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      when(_imageFileUseCase.pickMultiImage()).thenAnswer((_) async {
        return Success([File('path1'), File('path2')]);
      });

      await model.selectImages();

      model.debugState.when((_, __, ___, images, ____, _____, ______, _______,
          ________, _________) {
        expect(images.length, 2);
        expect(images.first.path, 'path1');
      }, loading: () {}, error: () {});
    });
  });

  group(
    'changeImage',
    () {
      test('with selected Files', () async {
        const shopId = 'shop_id_1';
        when(_shopUseCase.fetchShopByShopId(shopId: shopId))
            .thenAnswer((_) async {
          return Success(shopWithImage);
        });

        final url = Uri.parse('path1');
        when(http.get(url)).thenAnswer((_) async {
          return http.Response('path1', 200);
        });
        when(_pathUseCase.getTempDirectory()).thenAnswer((_) async {
          return Success(Directory('path1'));
        });

        final model = container.read(postShopProvider(shopId).notifier);
        await model.initShopState();

        model.debugState.when((_, __, ___, images, ____, _____, ______, _______,
            ________, _________) {
          expect(images.first.path, 'path1');
        }, loading: () {}, error: () {});

        when(_imageFileUseCase.pickImage()).thenAnswer((_) async {
          return Success(File('path2'));
        });

        await model.changeImage(0);

        model.debugState.when((_, __, ___, images, ____, _____, ______, _______,
            ________, _________) {
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
        return Success(shop);
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      model.debugState.when((_, __, ___, ____, _____, selectedServiceTags,
          ______, _______, ________, _________) {
        expect(selectedServiceTags.length, 0);
        expect(selectedServiceTags, []);
      }, loading: () {}, error: () {});

      model.addServiceTag(1);

      model.debugState.when((_, __, ___, ____, _____, selectedServiceTags,
          ______, _______, ________, _________) {
        expect(selectedServiceTags.length, 1);
        expect(selectedServiceTags, [1]);
      }, loading: () {}, error: () {});

      model.removeServiceTag(1);

      model.debugState.when((_, __, ___, ____, _____, selectedServiceTags,
          ______, _______, ________, _________) {
        expect(selectedServiceTags.length, 0);
        expect(selectedServiceTags, []);
      }, loading: () {}, error: () {});

      model.removeServiceTag(1);

      model.debugState.when((_, __, ___, ____, _____, selectedServiceTags,
          ______, _______, ________, _________) {
        expect(selectedServiceTags.length, 0);
        expect(selectedServiceTags, []);
      }, loading: () {}, error: () {});
    });
  });

  group('add or remove area tag', () {
    test('when _PostShopState', () async {
      const shopId = 'shop_id_1';
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(shop);
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      model.debugState.when((_, __, ___, ____, _____, ______, selectedAreaTags,
          _______, ________, _________) {
        expect(selectedAreaTags.length, 0);
        expect(selectedAreaTags, []);
      }, loading: () {}, error: () {});

      model.addAreaTag(1);

      model.debugState.when((_, __, ___, ____, _____, ______, selectedAreaTags,
          _______, ________, _________) {
        expect(selectedAreaTags.length, 1);
        expect(selectedAreaTags, [1]);
      }, loading: () {}, error: () {});

      model.removeAreaTag(1);

      model.debugState.when((_, __, ___, ____, _____, ______, selectedAreaTags,
          _______, ________, _________) {
        expect(selectedAreaTags.length, 0);
        expect(selectedAreaTags, []);
      }, loading: () {}, error: () {});
    });
  });

  group('add or remove food tag', () {
    test('when _PostShopState', () async {
      const shopId = 'shop_id_1';
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(shop);
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      model.debugState.when((_, __, ___, ____, _____, ______, _______,
          selectedFoodTags, ________, _________) {
        expect(selectedFoodTags.length, 0);
        expect(selectedFoodTags, []);
      }, loading: () {}, error: () {});

      model.addFoodTag(1);

      model.debugState.when((_, __, ___, ____, _____, ______, _______,
          selectedFoodTags, ________, _________) {
        expect(selectedFoodTags.length, 1);
        expect(selectedFoodTags, [1]);
      }, loading: () {}, error: () {});

      model.removeFoodTag(1);

      model.debugState.when((_, __, ___, ____, _____, ______, _______,
          selectedFoodTags, ________, _________) {
        expect(selectedFoodTags.length, 0);
        expect(selectedFoodTags, []);
      }, loading: () {}, error: () {});
    });
  });

  group('selectPostUser', () {
    test('when tap a user button1', () async {
      const shopId = 'shop_id_1';
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(shop);
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      model.debugState.when((_, __, ___, ____, _____, ______, _______, ________,
          postUserName, _________) {
        expect(postUserName, '');
      }, loading: () {}, error: () {});

      model.selectPostUser(1);

      model.debugState.when((_, __, ___, ____, _____, ______, _______, ________,
          postUserName, _________) {
        expect(postUserName, PostUsers.postUsers[1]);
      }, loading: () {
        // ignore: avoid_print
        print('test is not passed');
      }, error: () {
        // ignore: avoid_print
        print('test is not passed');
      });
    });
  });

  group('deleteImage', () {
    test('when selected button is tapped', () async {
      const shopId = 'shop_id_1';
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(shop);
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      when(_imageFileUseCase.pickMultiImage()).thenAnswer((_) async {
        return Success([File('path1'), File('path2')]);
      });

      await model.selectImages();
      model.deleteSelectedImage(0);

      model.debugState.when((_, __, ___, images, ____, _____, ______, _______,
          ________, _________) {
        expect(images.length, 1);
        expect(images.first.path, 'path2');
      }, loading: () {
        // ignore: avoid_print
        print('test is not passed');
      }, error: () {
        // ignore: avoid_print
        print('test is not passed');
      });
    });
  });

  group('removeSelectedUser', () {
    test('when delete image button is tapped', () async {
      const shopId = 'shop_id_1';
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(shop);
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      model.debugState.when((_, __, ___, ____, _____, ______, _______, ________,
          postUserName, _________) {
        expect(postUserName, '');
      }, loading: () {}, error: () {});

      model.selectPostUser(1);
      model.removeSelectedUser();

      model.debugState.when((_, __, ___, ____, _____, ______, _______, ________,
          postUserName, _________) {
        expect(postUserName, '');
      }, loading: () {
        // ignore: avoid_print
        print('test is not passed');
      }, error: () {
        // ignore: avoid_print
        print('test is not passed');
      });
    });
  });

  group('postShop', () {
    test('when shop is null', () async {
      const shopId = 'shop_id_1';
      const _shop = null;
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(_shop);
      });

      when(_placesUseCase.searchShopDetailsByPlaceId(placeId: shopId))
          .thenAnswer((_) async {
        return Success(null);
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      final result = await model.postShop();

      expect(result, PostResults.abort);
    });

    test('when comment is empty string', () async {
      const shopId = 'shop_id_1';
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(shop);
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      model.editComment('');

      final result = await model.postShop();

      expect(result, PostResults.empty);
    });

    test('when image is empty list', () async {
      const shopId = 'shop_id_1';
      when(_shopUseCase.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(shop);
      });

      final model = container.read(postShopProvider(shopId).notifier);
      await model.initShopState();

      final result = await model.postShop();

      expect(result, PostResults.empty);
    });
  });
}
