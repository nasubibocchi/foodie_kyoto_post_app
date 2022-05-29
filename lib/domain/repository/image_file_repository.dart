import 'dart:io';

import 'package:foodie_kyoto_post_app/data/local/data_source/image_file_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/image_file_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageFileRepositoryProvider = Provider<ImageFileRepositoryImpl>((ref) =>
    ImageFileRepositoryImpl(dataSource: ref.read(imageFileDataSourceProvider)));

abstract class ImageFileRepository {
  Future<Result<List<File>>> pickMultiImage();

  Future<Result<File?>> pickImage();
}
