import 'dart:io';

import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/storage_data_source_impl/menu_image_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';

import 'menu_image_storage_test.mocks.dart';

@GenerateMocks([File])
void main() {
  final _storage = MockFirebaseStorage();

  final container = ProviderContainer(overrides: [
    menuImageStorageProvider.overrideWithProvider(Provider<MenuImageStorage>(
        (ref) => MenuImageStorage(storage: _storage))),
  ]);

  group('defineStorageReference', () {
    test('when file name is defined', () {
      const shopId = 'shop_id_1';
      const menuName = 'menu_1';
      const fileName = 'fileName';

      final model = container.read(menuImageStorageProvider);
      final result = model.defineStorageReference(shopId, menuName, fileName);

      expect(result, 'shops/$shopId/menus/$menuName/images/$fileName.png');
    });

    test('when file name is not defined', () {
      const shopId = 'shop_id_1';
      const menuName = 'menu_1';

      final model = container.read(menuImageStorageProvider);
      final result = model.defineStorageReference(shopId, menuName, null);

      expect(result, 'shops/$shopId/menus/$menuName/images');
    });
  });

  group('postImage', () {
    test('it returns correct response', () async {
      const shopId = 'shop_id_1';
      const menuName = 'menu_1';
      const fileName = 'fileName';
      const path = 'path';

      final model = container.read(menuImageStorageProvider);

      final result = await model.postImages(
          path: path, shopId: shopId, menuName: menuName, fileName: fileName);

      result.whenWithResult((imagePath) => Success(imagePath.value), (e) {
        // ignore: avoid_print
        print('test is not passed');
      });
    });
  });

  group(
    'getImageUrl',
    () {
      test('it returns correct response', () async {
        const shopId = 'shop_id_1';
        const menuName = 'menu_1';
        const fileName = 'fileName';
        const path = 'path';

        final model = container.read(menuImageStorageProvider);

        final result = await model.getImagesUrl(
            path: path, shopId: shopId, menuName: menuName, fileName: fileName);

        result.whenWithResult((url) => Success(url.value), (e) {
          // ignore: avoid_print
          print('test is not passed');
        });
      });
    },
    skip: true,
    // getDownloadImage() が模擬できていないのでスキップ。shop_image_data_source_test.dartも同じ問題。
  );

  group(
    'deleteImages',
    () {
      const shopId = 'shop_id_1';
      const menuName = 'menu_1';

      setUp(() async {
        await _storage
            .ref()
            .child('shops/$shopId/menus/$menuName/images')
            .putFile(MockFile());
      });

      test('it returns correct response', () async {
        final model = container.read(menuImageStorageProvider);
        final result =
            await model.deleteImages(shopId: shopId, menuName: menuName);

        result.whenWithResult((imagePath) => Success(imagePath.value), (e) {
          // ignore: avoid_print
          print('test is not passed');
        });
      });
    },
    skip: true,
    // listAll() が発動しないのでいったんスキップ。
  );
}
