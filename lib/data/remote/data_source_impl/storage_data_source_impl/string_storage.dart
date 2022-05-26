import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/storage_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final stringStorageProvider = Provider<StringStorage>(
    (ref) => StringStorage(storage: ref.read(storageProvider)));

class StringStorage {
  StringStorage({required FirebaseStorage storage}) : _storage = storage;

  final FirebaseStorage _storage;

  Future<Result<String?>> postImages(
      {required String path,
      required String shopId,
      required String fileName}) async {
    final file = File(path);

    try {
      await _storage
          .ref()
          .child('shops/$shopId/images/$fileName.png')
          .putFile(file);
      return Success('shops/$shopId/images/$fileName.png');
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<String?>> getImagesUrl(
      {required String path,
      required String shopId,
      required String fileName}) async {
    try {
      final url = await _storage
          .ref()
          .child('shops/$shopId/images/$fileName.png')
          .getDownloadURL();
      return Success(url);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<String>> deleteImages({required String shopId}) async {
    try {
      await _storage.ref().child('shops/$shopId/images/').delete();
      return Success('shops/$shopId/images/');
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
