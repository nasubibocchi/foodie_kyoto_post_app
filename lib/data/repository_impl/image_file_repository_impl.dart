import 'dart:io';

import 'package:foodie_kyoto_post_app/data/local/data_source/image_file_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/repository/image_file_repository.dart';

class ImageFileRepositoryImpl implements ImageFileRepository {
  ImageFileRepositoryImpl({required ImageFileDataSource dataSource})
      : _dataSource = dataSource;

  final ImageFileDataSource _dataSource;

  @override
  Future<Result<File?>> pickImage() async {
    final fileResult = await _dataSource.pickImage();

    return fileResult.whenWithResult(
      (file) => Success(file.value),
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<List<File>>> pickMultiImage() async {
    final fileResult = await _dataSource.pickMultiImage();

    return fileResult.whenWithResult(
      (fileList) => Success(fileList.value),
      (e) => Error(Exception(e)),
    );
  }
}
