import 'dart:io';

import 'package:foodie_kyoto_post_app/data/local/data_source_impl/image_file_data_source_impl.dart';
import 'package:foodie_kyoto_post_app/data/local/data_source_impl/image_picker_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageFileDataSourceProvider = Provider<ImageFileDataSourceImpl>((ref) =>
    ImageFileDataSourceImpl(picker: ref.read(imagePickerDataSourceProvider)));

abstract class ImageFileDataSource {
  Future<Result<List<File>>> pickMultiImage();

  Future<Result<File?>> pickImage();
}
