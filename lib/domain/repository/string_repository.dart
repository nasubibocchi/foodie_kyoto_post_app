import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/string_data_source.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/string_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final stringRepositoryProvider = Provider<StringRepositoryImpl>((ref) =>
    StringRepositoryImpl(dataSource: ref.read(stringDataSourceProvider)));

abstract class StringRepository {
  Future<Result<String?>> postImages(
      {required String path, required String shopId, required String fileName});

  Future<Result<String?>> getImagesUrl(
      {required String path, required String shopId, required String fileName});
}
