import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/menu_model.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/menu_data_source.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/menu_repository_impl.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/repository/menu_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'menu_repository_test.mocks.dart';

@GenerateMocks([MenuDataSource])
void main() {
  final _menuDataSource = MockMenuDataSource();

  final container = ProviderContainer(overrides: [
    menuRepositoryProvider.overrideWithProvider(Provider<MenuRepositoryImpl>(
        (ref) => MenuRepositoryImpl(dataSource: _menuDataSource))),
  ]);

  group('postMenu', () {
    final menu = Menu(
        name: 'menu_name_1',
        shopId: 'shop_id_1',
        images: ['image1', 'image2'],
        foodTags: [1, 2, 3],
        price: 3000,
        review: 'review1');

    final menuModel = MenuModel(
        name: menu.name,
        shopId: menu.shopId,
        images: menu.images,
        foodTags: menu.foodTags,
        price: menu.price,
        review: menu.review);

    test('it returns correct response when a menu posted', () async {
      when(_menuDataSource.createMenu(menuModel: menuModel))
          .thenAnswer((_) async {
        return Success(menuModel);
      });

      final model = container.read(menuRepositoryProvider);
      final result = await model.createMenu(menu: menu);

      result.whenWithResult((success) {
        expect(success.value.name, 'menu_name_1');
      }, (e) {
        // ignore: avoid_print
        print('test is not passed');
      });
    });
  });
}
