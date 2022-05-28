import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/shop_image_data_source.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/storage_data_source_impl/shop_image_storage.dart';

class ShopImageDataSourceImpl implements ShopImageDataSource {
  ShopImageDataSourceImpl({required ShopImageStorage stringStorage})
      : _shopImageStorage = stringStorage;

  final ShopImageStorage _shopImageStorage;

  @override
  Future<Result<String?>> getImagesUrl(
      {required String path,
      required String shopId,
      required String fileName}) async {
    final storageResult = await _shopImageStorage.getImagesUrl(
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
    final storageResult = await _shopImageStorage.postImages(
        path: path, shopId: shopId, fileName: fileName);

    return storageResult.whenWithResult((url) {
      return Success(url.value);
    }, (e) {
      return Error(Exception(e));
    });
  }

  @override
  Future<Result<String>> deleteImages({required String shopId}) async {
    final storageResult = await _shopImageStorage.deleteImages(shopId: shopId);

    return storageResult.whenWithResult(
        (success) => Success(success.value), (e) => Error(Exception(e)));
  }
}
