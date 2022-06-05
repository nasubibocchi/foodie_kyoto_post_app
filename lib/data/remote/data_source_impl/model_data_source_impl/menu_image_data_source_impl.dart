import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/menu_image_data_source.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/storage_data_source_impl/menu_image_storage.dart';

class MenuImageDataSourceImpl implements MenuImageDataSource {
  MenuImageDataSourceImpl({required MenuImageStorage menuImageStorage})
      : _menuImageStorage = menuImageStorage;

  final MenuImageStorage _menuImageStorage;

  @override
  Future<Result<String?>> postImages(
      {required String path,
      required String shopId,
      required String menuName,
      required String fileName}) async {
    final storageResult = await _menuImageStorage.postImages(
        path: path, shopId: shopId, menuName: menuName, fileName: fileName);

    return storageResult.whenWithResult(
      (imagePath) => Success(imagePath.value),
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<String?>> getImagesUrl(
      {required String path,
      required String shopId,
      required String menuName,
      required String fileName}) async {
    final storageResult = await _menuImageStorage.getImagesUrl(
        path: path, shopId: shopId, menuName: menuName, fileName: fileName);

    return storageResult.whenWithResult(
      (url) => Success(url.value),
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<String>> deleteImages(
      {required String shopId, required String menuName}) async {
    final storageResult = await _menuImageStorage.deleteImages(
        shopId: shopId, menuName: menuName);

    return storageResult.whenWithResult(
      (imagePath) => Success(imagePath.value),
      (e) => Error(Exception(e)),
    );
  }
}
