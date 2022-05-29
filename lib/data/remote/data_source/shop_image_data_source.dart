import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/model_data_source_impl/shop_image_data_source_impl.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/storage_data_source_impl/shop_image_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final shopImageDataSourceProvider = Provider<ShopImageDataSourceImpl>((ref) =>
    ShopImageDataSourceImpl(stringStorage: ref.read(shopImageStorageProvider)));

abstract class ShopImageDataSource {
  Future<Result<String?>> postImages(
      {required String path, required String shopId, required String fileName});

  Future<Result<String?>> getImagesUrl(
      {required String path, required String shopId, required String fileName});

  Future<Result<String>> deleteImages({required String shopId});
}
