import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/model/shop_model.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/shop_data_source.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/shop_repository_impl.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/domain/repository/shop_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'shop_repository_test.mocks.dart';

@GenerateMocks([ShopDataSource])
void main() {
  final _shopDataSource = MockShopDataSource();

  final container = ProviderContainer(overrides: [
    shopRepositoryProvider.overrideWithProvider(
        Provider((ref) => ShopRepositoryImpl(dataSource: _shopDataSource)))
  ]);

  group('fetch shops', () {
    test('shop repository can correctly change data type shop_model to shop',
        () async {
      final List<Map<String, dynamic>> data = [
        {
          'name': 'name_1',
          'shop_id': 'shop_id_1',
          'position': {
            'geohash': 'xn0x1ktq9',
            'geopoint': {'latitude': 35.006323, 'longitude': 135.765321},
          },
          'comment': 'comment_1',
          'images': ['image1', 'image2'],
          'service_tags': [1, 2],
          'area_tags': [3, 4],
          'food_tags': [5, 6],
          'post_user': 'user1',
          'created_at': DateTime(2020, 1, 1),
        },
        {
          'name': 'name_2',
          'shop_id': 'shop_id_2',
          'position': {
            'geohash': 'xn0x1ktq9',
            'geopoint': {'latitude': 35.006323, 'longitude': 135.765321},
          },
          'comment': 'comment_2',
          'images': ['image1', 'image2'],
          'service_tags': [1, 2],
          'area_tags': [3, 4],
          'food_tags': [5, 6],
          'post_user': 'user1',
          'created_at': DateTime.now(),
        },
      ];
      when(_shopDataSource.fetchShops(limit: 10)).thenAnswer((_) async {
        return Success(data.map((e) => ShopModel.fromJson(e)).toList());
      });

      final model = container.read(shopRepositoryProvider);
      final shopResult = await model.fetchShops(limit: 10);

      // ShopModel -> Shop の変換確認
      expect(shopResult, isA<Success<List<Shop>>>());

      // dataの中身を確認
      shopResult.whenWithResult(
        (list) => expect(list.value.first.name, 'name_1'),
        (e) => expect(e, null),
      );
    });
  });

  group('postShop', () {
    test(
      'Testing shop to shop model',
      () async {
        final shop = Shop(
            name: 'name',
            shopId: 'shop_id',
            latitude: 50.0,
            longitude: 100.0,
            comment: 'comment',
            images: ['image1', 'image2'],
            serviceTags: [1, 2],
            areaTags: [3, 4],
            foodTags: [5, 6],
            postUser: 'user1');

        const shopModel = ShopModel(
            name: 'name',
            shopId: 'shop_id',
            latitude: 50.0,
            longitude: 100.0,
            comment: 'comment',
            images: ['image1', 'image2'],
            serviceTags: [1, 2],
            areaTags: [3, 4],
            foodTags: [5, 6],
            postUser: 'user1');

        when(_shopDataSource.postShop(shop: shopModel)).thenAnswer((_) async {
          return Success(null);
        });

        final model = container.read(shopRepositoryProvider);
        final result = await model.postShop(shop: shop);

        expect(result, isA<Result<void>>());
      },
      skip: true,
    );
  });

  group('fetch shop by shop id', () {
    test('when there is a shop', () async {
      const shopId = 'shop_id_1';
      when(_shopDataSource.fetchShopByShopId(shopId: shopId))
          .thenAnswer((_) async {
        return Success(const ShopModel(
            name: 'name',
            shopId: 'shop_id_1',
            latitude: 100.0,
            longitude: 100.0,
            comment: 'comment',
            images: ['image_1', 'image_2'],
            serviceTags: [1, 2],
            areaTags: [3, 4],
            foodTags: [5, 6],
            postUser: 'user1'));
      });

      final model = container.read(shopRepositoryProvider);
      final result = await model.fetchShopByShopId(shopId: shopId);

      expect(result, isA<Result<Shop?>>());

      result.whenWithResult(
        (shop) => expect(shop.value?.shopId, 'shop_id_1'),
        (e) => expect(e, Error(Exception('Unhendled part, could be anything'))),
      );
    });
  });
}
