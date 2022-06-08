import 'dart:io';

import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/repository/movie_file_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final movieFileUseCaseProvider = Provider<MovieFileUseCase>((ref) =>
    MovieFileUseCase(repository: ref.read(movieFileRepositoryProvider)));

class MovieFileUseCase {
  MovieFileUseCase({required MovieFileRepository repository})
      : _repository = repository;

  final MovieFileRepository _repository;

  Future<Result<File?>> pickVideo() => _repository.pickVideo();
}
