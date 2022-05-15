import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/model/shop_model.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/shop_data_source.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/domain/repository/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  ShopRepositoryImpl({required ShopDataSource dataSource})
      : _dataSource = dataSource;
  final ShopDataSource _dataSource;

  @override
  Future<Result<List<Shop>>> fetchShops(
      {required int limit, String? cursor}) async {
    final appShopList =
        await _dataSource.fetchShops(limit: limit, cursor: cursor);

    return appShopList.whenWithResult(
        (data) => Success(data.value
            .map((e) => Shop(
                  name: e.name,
                  shopId: e.shopId,
                  latitude: e.latitude,
                  longitude: e.longitude,
                  comment: e.comment,
                  images: e.images,
                  tags: e.tags,
                  postUser: e.postUser,
                ))
            .toList()),
        (e) => Error(Exception(e)));
  }

  @override
  Future<Result<void>> postShop({required Shop shop}) async {
    final shopModel = ShopModel(
        name: shop.name,
        shopId: shop.shopId,
        latitude: shop.latitude,
        longitude: shop.longitude,
        comment: shop.comment,
        images: shop.images,
        tags: shop.tags,
        postUser: shop.postUser);

    final postResult = await _dataSource.postShop(shop: shopModel);

    return postResult.whenWithResult(
      (success) => Success(null),
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<Shop?>> fetchShopByShopId({required String shopId}) async {
    final shopResult = await _dataSource.fetchShopByShopId(shopId: shopId);

    return shopResult.whenWithResult(
      (shop) {
        if (shop.value != null) {
          return Success(Shop(
              name: shop.value!.name,
              shopId: shop.value!.shopId,
              latitude: shop.value!.latitude,
              longitude: shop.value!.longitude,
              comment: shop.value!.comment,
              images: shop.value!.images,
              tags: shop.value!.tags,
              postUser: shop.value!.postUser));
        } else {
          return Success(null);
        }
      },
      (e) => Error(Exception(e)),
    );
  }
}
