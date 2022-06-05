import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/menu_image_data_source.dart';
import 'package:foodie_kyoto_post_app/domain/repository/menu_image_repository.dart';

class MenuImageRepositoryImpl implements MenuImageRepository {
  MenuImageRepositoryImpl({required MenuImageDataSource dataSource})
      : _dataSource = dataSource;

  final MenuImageDataSource _dataSource;

  @override
  Future<Result<String?>> postImages(
      {required String path,
      required String shopId,
      required String menuName,
      required String fileName}) async {
    final result = await _dataSource.postImages(
        path: path, shopId: shopId, menuName: menuName, fileName: fileName);

    return result.whenWithResult(
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
    final result = await _dataSource.getImagesUrl(
        path: path, shopId: shopId, menuName: menuName, fileName: fileName);

    return result.whenWithResult(
      (url) => Success(url.value),
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<String>> deleteImages(
      {required String shopId, required String menuName}) async {
    final result =
        await _dataSource.deleteImages(shopId: shopId, menuName: menuName);

    return result.whenWithResult(
      (imagePath) => Success(imagePath.value),
      (e) => Error(Exception(e)),
    );
  }
}
