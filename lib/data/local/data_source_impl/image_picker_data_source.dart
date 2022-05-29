import 'package:foodie_kyoto_post_app/data/local/image_picker_provider.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerDataSourceProvider = Provider<ImagePickerDataSource>(
    (ref) => ImagePickerDataSource(picker: ref.read(imagePickerProvider)));

class ImagePickerDataSource {
  ImagePickerDataSource({required ImagePicker picker}) : _picker = picker;

  final ImagePicker _picker;

  Future<Result<List<XFile>?>> pickMultiImage() async {
    try {
      final pickerResult = await _picker.pickMultiImage();
      return Success(pickerResult);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<XFile?>> pickImage() async {
    try {
      final pickResult = await _picker.pickImage(source: ImageSource.gallery);
      return Success(pickResult);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
