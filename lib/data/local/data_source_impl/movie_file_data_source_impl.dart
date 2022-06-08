import 'dart:io';

import 'package:foodie_kyoto_post_app/data/local/data_source/movie_file_data_source.dart';
import 'package:foodie_kyoto_post_app/data/local/data_source_impl/image_picker_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';

class MovieFileDataSourceImpl implements MovieFileDataSource {
  MovieFileDataSourceImpl({required ImagePickerDataSource picker})
      : _picker = picker;

  final ImagePickerDataSource _picker;

  @override
  Future<Result<File?>> pickVideo() async {
    final fileResult = await _picker.pickVideo();

    return fileResult.whenWithResult(
      (xFile) {
        if (xFile.value?.path != null) {
          return Success(File(xFile.value!.path));
        } else {
          return Success(null);
        }
      },
      (e) => Error(Exception(e)),
    );
  }
}
