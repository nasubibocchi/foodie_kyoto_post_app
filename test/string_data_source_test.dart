import 'dart:io';

import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/string_data_source.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/model_data_source_impl/string_data_source_impl.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/storage_data_source_impl/string_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'string_data_source_test.mocks.dart';

@GenerateMocks([StringStorage])
void main() {
  final _storage = MockFirebaseStorage();
  final _stringStorage = MockStringStorage();

  final container = ProviderContainer(overrides: [
    stringStorageProvider.overrideWithProvider(
        Provider<StringStorage>((ref) => StringStorage(storage: _storage))),
    stringDataSourceProvider.overrideWithProvider(
        Provider<StringDataSourceImpl>((ref) => StringDataSourceImpl(
            stringStorage: ref.read(stringStorageProvider))))
  ]);

  setUpAll(() async {
    // TestWidgetsFlutterBinding.ensureInitialized();

    const shopId = 'shop_id_1';
    const fileName = '1';

    final file = File('$fileName.png');

    // const MethodChannel channel =
    //     MethodChannel('plugins.flutter.io/firebase_storage');
    // channel.setMockMethodCallHandler((methodCall) async {
    //   if (methodCall.method == 'putFile') {
    //     return 'shops/$shopId/images/$fileName.png';
    //   }
    //   if (methodCall.method == 'getDownloadURL') {
    //     return 'url';
    //   }
    //   if (methodCall.method == 'delete') {
    //     return 'shops/$shopId/images/';
    //   }
    //   if (methodCall.method == 'listAll') {
    //     return '$fileName.png';
    //   }
    // });

    await _storage
        .ref()
        .child('shops')
        .child(shopId)
        .child('images')
        .child('$fileName.png')
        .putFile(file);
  });

  group('postImages', () {
    const shopId = 'shop_id_1';
    const path = 'path';
    const fileName = '2';

    test('post with valid path and shop id', () async {
      when(_stringStorage.postImages(
              path: path, shopId: shopId, fileName: fileName))
          .thenAnswer((_) async {
        final file = File(path);
        await _storage
            .ref()
            .child('shops')
            .child(shopId)
            .child('images')
            .child('$fileName.png')
            .putFile(file);
        return Success('shops/$shopId/images/$fileName.png');
      });

      final model = container.read(stringDataSourceProvider);
      final result = await model.postImages(
          path: path, shopId: shopId, fileName: fileName);

      result.whenWithResult(
        (path) {
          expect(path.value, 'shops/$shopId/images/$fileName.png');
        },
        (e) => expect(e, Exception('Unhendled part, could be anything')),
      );
    });
  });

  group(
    'getImagesUrl',
    () {
      const shopId = 'shop_id_1';
      const path = 'path';
      const fileName = '1';

      test('get images url with valid path and shopId', () async {
        when(_stringStorage.getImagesUrl(
                path: path, shopId: shopId, fileName: fileName))
            .thenAnswer((_) async {
          // getDownloadURL(); で値が返ってこない
          final url = await _storage
              .ref()
              .child('shops')
              .child(shopId)
              .child('images')
              .child('$fileName.png')
              .getDownloadURL();

          return Success(url);
        });

        final model = container.read(stringDataSourceProvider);
        final result = await model.getImagesUrl(
            path: path, shopId: shopId, fileName: fileName);

        result.whenWithResult(
          (url) {
            expect(url.value, isA<Result<String?>>());
          },
          (e) => expect(e, Exception('Unhendled part, could be anything')),
        );
      });
    },
    skip: true,
  );

  group(
    'deleteImages',
    () {
      test('when there are images in designated path', () async {
        const shopId = 'shop_id_1';

        when(_stringStorage.deleteImages(shopId: shopId)).thenAnswer((_) async {
          // listAll(); で値が返ってこない
          final fileList = await _storage
              .ref()
              .child('shops')
              .child(shopId)
              .child('images')
              .listAll();

          if (fileList.items.isNotEmpty) {
            for (int i = 0; i < fileList.items.length; i++) {
              await _storage
                  .ref()
                  .child('shops')
                  .child(shopId)
                  .child('images')
                  .child('$i.png')
                  .delete();
            }
          }
          return Success('shops/$shopId/images/');
        });

        final model = container.read(stringDataSourceProvider);
        final result = await model.deleteImages(shopId: shopId);

        result.whenWithResult(
          (success) => expect(success.value, 'shops/$shopId/images/'),
          (e) => expect(e, Exception('Unhendled part, could be anything')),
        );
      });
    },
    skip: true,
  );
}
