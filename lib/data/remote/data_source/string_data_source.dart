import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/model_data_source_impl/string_data_source_impl.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/storage_data_source_impl/string_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final stringDataSourceProvider = Provider<StringDataSourceImpl>((ref) =>
    StringDataSourceImpl(stringStorage: ref.read(stringStorageProvider)));

abstract class StringDataSource {
  Future<Result<String?>> postImages(
      {required String path, required String shopId, required String fileName});

  Future<Result<String?>> getImagesUrl(
      {required String path, required String shopId, required String fileName});

  Future<Result<String>> deleteImages(
      {required String path, required String shopId});
}
