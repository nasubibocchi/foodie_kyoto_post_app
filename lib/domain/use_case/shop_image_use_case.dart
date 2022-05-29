import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/repository/shop_image_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final shopImageUseCaseProvider = Provider<ShopImageUseCase>((ref) =>
    ShopImageUseCase(repository: ref.read(shopImageRepositoryProvider)));

class ShopImageUseCase {
  ShopImageUseCase({required ShopImageRepository repository})
      : _repository = repository;

  final ShopImageRepository _repository;

  Future<Result<String?>> postImages(
          {required String path,
          required String shopId,
          required String fileName}) =>
      _repository.postImages(path: path, shopId: shopId, fileName: fileName);

  Future<Result<String?>> getImagesUrl(
          {required String path,
          required String shopId,
          required String fileName}) =>
      _repository.getImagesUrl(path: path, shopId: shopId, fileName: fileName);

  Future<Result<String>> deleteImages({required String shopId}) =>
      _repository.deleteImages(shopId: shopId);
}
