import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/menu_image_data_source.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/menu_image_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuImageRepositoryProvider = Provider<MenuImageRepositoryImpl>((ref) =>
    MenuImageRepositoryImpl(dataSource: ref.read(menuImageDataSourceProvider)));

abstract class MenuImageRepository {
  Future<Result<String?>> postImages(
      {required String path,
      required String shopId,
      required String menuName,
      required String fileName});

  Future<Result<String?>> getImagesUrl(
      {required String path,
      required String shopId,
      required String menuName,
      required String fileName});

  Future<Result<String>> deleteImages(
      {required String shopId, required String menuName});
}
