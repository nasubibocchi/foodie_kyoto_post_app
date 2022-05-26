import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/string_data_source.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/storage_data_source_impl/string_storage.dart';

class StringDataSourceImpl implements StringDataSource {
  StringDataSourceImpl({required StringStorage stringStorage})
      : _stringStorage = stringStorage;

  final StringStorage _stringStorage;

  @override
  Future<Result<String?>> getImagesUrl(
      {required String path,
      required String shopId,
      required String fileName}) async {
    final storageResult = await _stringStorage.getImagesUrl(
        path: path, shopId: shopId, fileName: fileName);

    return storageResult.whenWithResult((imagePath) {
      return Success(imagePath.value);
    }, (e) {
      return Error(Exception(e));
    });
  }

  @override
  Future<Result<String?>> postImages(
      {required String path,
      required String shopId,
      required String fileName}) async {
    final storageResult = await _stringStorage.postImages(
        path: path, shopId: shopId, fileName: fileName);

    return storageResult.whenWithResult((url) {
      return Success(url.value);
    }, (e) {
      return Error(Exception(e));
    });
  }
}
