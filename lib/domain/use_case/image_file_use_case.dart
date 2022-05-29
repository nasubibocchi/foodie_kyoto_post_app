import 'dart:io';

import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/repository/image_file_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageFileUseCaseProvider = Provider<ImageFileUseCase>((ref) =>
    ImageFileUseCase(repository: ref.read(imageFileRepositoryProvider)));

class ImageFileUseCase {
  ImageFileUseCase({required ImageFileRepository repository})
      : _repository = repository;

  final ImageFileRepository _repository;

  Future<Result<List<File>>> pickMultiImage() => _repository.pickMultiImage();

  Future<Result<File?>> pickImage() => _repository.pickImage();
}
