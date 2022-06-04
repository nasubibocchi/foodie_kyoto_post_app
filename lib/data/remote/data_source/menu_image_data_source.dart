import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/model_data_source_impl/menu_image_data_source_impl.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/storage_data_source_impl/menu_image_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuImageDataSourceProvider = Provider<MenuImageDataSourceImpl>((ref) =>
    MenuImageDataSourceImpl(
        menuImageStorage: ref.read(menuImageStorageProvider)));

abstract class MenuImageDataSource {
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
