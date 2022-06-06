import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/menu_model.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/menu_data_source.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/firestore_data_source_impl/menu_firestore.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/model_data_source_impl/menu_data_source_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'menu_data_source_test.mocks.dart';

@GenerateMocks([MenuFirestore])
void main() {
  final _firestore = FakeFirebaseFirestore();
  final _menuFirestore = MockMenuFirestore();

  final container = ProviderContainer(overrides: [
    menuFirestoreProvider.overrideWithProvider(
        Provider<MenuFirestore>((ref) => MenuFirestore(firestore: _firestore))),
    menuDataSourceProvider.overrideWithProvider(Provider<MenuDataSourceImpl>(
        (ref) => MenuDataSourceImpl(
            menuFirestore: ref.read(menuFirestoreProvider)))),
  ]);

  group('postShop', () {
    final menuData = {
      'name': 'menu_name_1',
      'shop_id': 'shop_id_1',
      'images': ['image1', 'image2'],
      'movies': ['movie1', 'movie2'],
      'food_tags': [1, 2, 3],
      'price': 3000,
      'review': 'review1',
      'en_review': 'en_review1',
      'post_user': 'user1',
    };

    test('it returns correct response when a menu posted', () async {
      when(_menuFirestore.createMenu(menuData: menuData)).thenAnswer((_) async {
        final ref = _firestore
            .collection('shops')
            .doc(menuData['shop_id'] as String)
            .collection('menus');

        await ref.add(<String, dynamic>{
          'name': 'menu_name_1',
          'shop_id': 'shop_id_1',
          'images': ['image1', 'image2'],
          'movies': ['movie1', 'movie2'],
          'food_tags': [1, 2, 3],
          'price': 3000,
          'review': 'review1',
          'en_review': 'en_review1',
          'post_user': 'user1',
        });

        return Success(menuData);
      });

      final model = container.read(menuDataSourceProvider);
      final result =
          await model.createMenu(menuModel: MenuModel.fromJson(menuData));

      result.whenWithResult((success) {
        expect(
            success.value,
            MenuModel(
                name: 'menu_name_1',
                shopId: 'shop_id_1',
                images: ['image1', 'image2'],
                movies: ['movie1', 'movie2'],
                foodTags: [1, 2, 3],
                price: 3000,
                review: 'review1',
                enReview: 'en_review1',
                postUser: 'user1'));
      }, (e) {
        // ignore: avoid_print
        print('test is not passed');
      });
    });
  });

  group('fetchShopMenus', () {
    const shopId = 'shop_id_2';
    final menuData = {
      'name': 'menu_name_1',
      'shop_id': 'shop_id_1',
      'images': ['image1', 'image2'],
      'movies': ['movie1', 'movie2'],
      'food_tags': [1, 2, 3],
      'price': 3000,
      'review': 'review1',
      'en_review': 'en_review1',
      'post_user': 'user1',
    };

    final ref = _firestore.collection('shops').doc(shopId).collection('menus');

    final model = container.read(menuDataSourceProvider);

    test('when there is no menu to return', () async {
      when(_menuFirestore.fetchShopMenus(shopId: shopId)).thenAnswer((_) async {
        final data = await ref.get();
        return Success(data);
      });

      final result = await model.fetchShopMenus(shopId: shopId);

      result.whenWithResult((success) {
        expect(success.value, <MenuModel>[]);
      }, (e) {
        // ignore: avoid_print
        print('test is not passed');
      });
    });

    test('when there is a menu to return', () async {
      await ref.add(menuData);

      when(_menuFirestore.fetchShopMenus(shopId: shopId)).thenAnswer((_) async {
        final data = await ref.get();
        return Success(data);
      });

      final result = await model.fetchShopMenus(shopId: shopId);

      result.whenWithResult((success) {
        expect(success.value.length, 1);
        expect(success.value.first, MenuModel.fromJson(menuData));
      }, (e) {
        // ignore: avoid_print
        print('test is not passed');
      });
    });
  });
}
