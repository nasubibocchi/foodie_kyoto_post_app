import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/repository/menu_image_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuImageUseCaseProvider = Provider<MenuImageUseCase>((ref) =>
    MenuImageUseCase(repository: ref.read(menuImageRepositoryProvider)));

class MenuImageUseCase {
  MenuImageUseCase({required MenuImageRepository repository})
      : _repository = repository;

  final MenuImageRepository _repository;

  Future<Result<String?>> postImages(
          {required String path,
          required String shopId,
          required String menuName,
          required String fileName}) =>
      _repository.postImages(
          path: path, shopId: shopId, menuName: menuName, fileName: fileName);

  Future<Result<String?>> getImagesUrl(
          {required String path,
          required String shopId,
          required String menuName,
          required String fileName}) =>
      _repository.getImagesUrl(
          path: path, shopId: shopId, menuName: menuName, fileName: fileName);

  Future<Result<String>> deleteImages(
          {required String shopId, required String menuName}) =>
      _repository.deleteImages(shopId: shopId, menuName: menuName);
}
