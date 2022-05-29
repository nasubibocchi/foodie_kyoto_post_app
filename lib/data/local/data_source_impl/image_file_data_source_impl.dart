import 'dart:io';

import 'package:foodie_kyoto_post_app/data/local/data_source/image_file_data_source.dart';
import 'package:foodie_kyoto_post_app/data/local/data_source_impl/image_picker_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';

class ImageFileDataSourceImpl implements ImageFileDataSource {
  ImageFileDataSourceImpl({required ImagePickerDataSource picker})
      : _picker = picker;

  final ImagePickerDataSource _picker;

  @override
  Future<Result<List<File>>> pickMultiImage() async {
    final xFileResult = await _picker.pickMultiImage();

    return xFileResult.whenWithResult(
      (xFileList) {
        if (xFileList.value != null) {
          final fileList = xFileList.value!.map((e) => File(e.path)).toList();
          return Success(fileList);
        } else {
          return Success(<File>[]);
        }
      },
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<File?>> pickImage() async {
    final xFileResult = await _picker.pickImage();

    return xFileResult.whenWithResult(
      (xFile) {
        if (xFile.value != null) {
          final file = File(xFile.value!.path);
          return Success(file);
        } else {
          return Success(null);
        }
      },
      (e) => Error(Exception(e)),
    );
  }
}
