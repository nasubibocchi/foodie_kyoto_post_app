import 'dart:io';

import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/repository/path_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pathUseCaseProvider = Provider<PathUseCase>(
    (ref) => PathUseCase(repository: ref.read(pathRepositoryProvider)));

class PathUseCase {
  PathUseCase({required PathRepository repository}) : _repository = repository;

  final PathRepository _repository;

  Future<Result<Directory>> getTempDirectory() =>
      _repository.getTempDirectory();
}
