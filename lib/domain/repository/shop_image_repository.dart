import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/shop_image_data_source.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/shop_image_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final shopImageRepositoryProvider = Provider<ShopImageRepositoryImpl>((ref) =>
    ShopImageRepositoryImpl(dataSource: ref.read(shopImageDataSourceProvider)));

abstract class ShopImageRepository {
  Future<Result<String?>> postImages(
      {required String path, required String shopId, required String fileName});

  Future<Result<String?>> getImagesUrl(
      {required String path, required String shopId, required String fileName});

  Future<Result<String>> deleteImages({required String shopId});
}
