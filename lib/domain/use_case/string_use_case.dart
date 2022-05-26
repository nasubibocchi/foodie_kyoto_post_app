import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/repository/string_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final stringUseCaseProvider = Provider<StringUseCase>(
    (ref) => StringUseCase(repository: ref.read(stringRepositoryProvider)));

class StringUseCase {
  StringUseCase({required StringRepository repository})
      : _repository = repository;

  final StringRepository _repository;

  Future<Result<String?>> postImages(
          {required String path, required String shopId}) =>
      _repository.postImages(path: path, shopId: shopId);

  Future<Result<String?>> getImagesUrl(
          {required String path, required String shopId}) =>
      _repository.getImagesUrl(path: path, shopId: shopId);
}
