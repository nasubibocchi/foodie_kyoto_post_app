import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/string_data_source.dart';
import 'package:foodie_kyoto_post_app/domain/repository/string_repository.dart';

class StringRepositoryImpl implements StringRepository {
  StringRepositoryImpl({required StringDataSource dataSource})
      : _dataSource = dataSource;

  final StringDataSource _dataSource;

  @override
  Future<Result<String?>> getImagesUrl(
      {required String path,
      required String shopId,
      required String fileName}) async {
    final result = await _dataSource.getImagesUrl(
        path: path, shopId: shopId, fileName: fileName);

    return result.whenWithResult((url) {
      return Success(url.value);
    }, (e) {
      return Error(Exception(e));
    });
  }

  @override
  Future<Result<String?>> postImages(
      {required String path,
      required String shopId,
      required String fileName}) async {
    final result = await _dataSource.postImages(
        path: path, shopId: shopId, fileName: fileName);

    return result.whenWithResult((imagePath) {
      return Success(imagePath.value);
    }, (e) {
      return Error(Exception(e));
    });
  }

  @override
  Future<Result<String>> deleteImages({required String shopId}) async {
    final result = await _dataSource.deleteImages(shopId: shopId);

    return result.whenWithResult(
        (success) => Success(success.value), (e) => Error(Exception(e)));
  }
}
