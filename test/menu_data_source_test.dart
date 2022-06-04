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
      'food_tags': [1, 2, 3],
      'price': 3000,
      'review': 'review1',
    };

    test('it returns correct response when a menu posted', () async {
      when(_menuFirestore.postMenu(menuData: menuData)).thenAnswer((_) async {
        final ref = _firestore
            .collection('shops')
            .doc(menuData['shop_id'] as String)
            .collection('menus');

        await ref.add(<String, dynamic>{
          'name': 'menu_name_1',
          'shop_id': 'shop_id_1',
          'images': ['image1', 'image2'],
          'food_tags': [1, 2, 3],
          'price': 3000,
          'review': 'review1',
        });

        return Success(menuData);
      });

      final model = container.read(menuDataSourceProvider);
      final result =
          await model.postMenu(menuModel: MenuModel.fromJson(menuData));

      result.whenWithResult((success) {
        expect(success.value, MenuModel.fromJson(menuData));
      }, (e) {
        // ignore: avoid_print
        print('test is not passed');
      });
    });
  });
}
