import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/storage_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final shopImageStorageProvider = Provider<ShopImageStorage>(
    (ref) => ShopImageStorage(storage: ref.read(storageProvider)));

class ShopImageStorage {
  ShopImageStorage({required FirebaseStorage storage}) : _storage = storage;

  final FirebaseStorage _storage;
  static const shopRef = 'shops';
  static const imageRef = 'images';

  // 現状リファレンス先の削除〜画像追加＋パス名取得までを切り離して実行することが
  // ないので、パス名はここで定義して各関数で呼び出す。
  String defineStorageReference(String shopId, String? fileName) {
    if (fileName == null) {
      return '$shopRef/$shopId/$imageRef';
    } else {
      return '$shopRef/$shopId/$imageRef/$fileName.png';
    }
  }

  Future<Result<String?>> postImages(
      {required String path,
      required String shopId,
      required String fileName}) async {
    final file = File(path);

    try {
      final ref = defineStorageReference(shopId, fileName);
      await _storage.ref().child(ref).putFile(file);
      return Success(ref);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<String?>> getImagesUrl(
      {required String path,
      required String shopId,
      required String fileName}) async {
    try {
      final ref = defineStorageReference(shopId, fileName);
      final url = await _storage.ref().child(ref).getDownloadURL();
      return Success(url);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<String>> deleteImages({required String shopId}) async {
    try {
      final directoryRef = defineStorageReference(shopId, null);
      final fileList = await _storage.ref().child(directoryRef).listAll();

      if (fileList.items.isNotEmpty) {
        for (int i = 0; i < fileList.items.length; i++) {
          final ref = defineStorageReference(shopId, '$i');
          await _storage.ref().child(ref).delete();
        }
      }

      return Success(directoryRef);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
