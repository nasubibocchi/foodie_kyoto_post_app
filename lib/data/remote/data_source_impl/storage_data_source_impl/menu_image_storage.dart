import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/storage_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuImageStorageProvider = Provider<MenuImageStorage>(
    (ref) => MenuImageStorage(storage: ref.read(storageProvider)));

class MenuImageStorage {
  MenuImageStorage({required FirebaseStorage storage}) : _storage = storage;

  final FirebaseStorage _storage;
  static const shopRef = 'shops';
  static const menuRef = 'menus';
  static const imageRef = 'images';

  String defineStorageReference(
      String shopId, String menuName, String? fileName) {
    if (fileName == null) {
      return '$shopRef/$shopId/$menuRef/$menuName/$imageRef';
    } else {
      return '$shopRef/$shopId/$menuRef/$menuName/$imageRef/$fileName.png';
    }
  }

  Future<Result<String?>> postImages(
      {required String path,
      required String shopId,
      required String menuName,
      required String fileName}) async {
    final file = File(path);

    try {
      final ref = defineStorageReference(shopId, menuName, fileName);
      await _storage.ref().child(ref).putFile(file);
      return Success(ref);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<String?>> getImagesUrl(
      {required String path,
      required String shopId,
      required String menuName,
      required String fileName}) async {
    try {
      final ref = defineStorageReference(shopId, menuName, fileName);
      final url = await _storage.ref().child(ref).getDownloadURL();
      return Success(url);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<String>> deleteImages(
      {required String shopId, required menuName}) async {
    try {
      final directoryRef = defineStorageReference(shopId, menuName, null);
      final fileList = await _storage.ref().child(directoryRef).listAll();

      if (fileList.items.isNotEmpty) {
        for (int i = 0; i < fileList.items.length; i++) {
          final ref = defineStorageReference(shopId, menuName, '$i');
          if (ref.isNotEmpty) {
            await _storage.ref().child(ref).delete();
          }
        }
      }

      return Success(directoryRef);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
