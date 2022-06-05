import 'dart:async';

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
  StreamController<Stream<List<Shop>>> get shopRepositoryStreamController =>
      _shopRepositoryStreamController;

  final _shopRepositoryStreamController =
      StreamController<Stream<List<Shop>>>();

  @override
  set shopRepositoryStreamController(
          StreamController<Stream<List<Shop>>>?
              _shopRepositoryStreamController) =>
      _shopRepositoryStreamController;

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
                  serviceTags: e.serviceTags,
                  areaTags: e.areaTags,
                  foodTags: e.foodTags,
                  postUser: e.postUser,
                  price: e.price,
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
        serviceTags: shop.serviceTags,
        areaTags: shop.areaTags,
        foodTags: shop.foodTags,
        postUser: shop.postUser,
        price: shop.price);

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
              serviceTags: shop.value!.serviceTags,
              areaTags: shop.value!.areaTags,
              foodTags: shop.value!.foodTags,
              postUser: shop.value!.postUser,
              price: shop.value!.price));
        } else {
          return Success(null);
        }
      },
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<String>> fetchShopInMapStream(
      {required double latitude,
      required double longitude,
      required radius}) async {
    final result = await _dataSource.fetchShopInMapStream(
        latitude: latitude, longitude: longitude, radius: radius);

    return result.whenWithResult(
      (success) {
        _dataSource.shopDataSourceStreamController?.stream.listen((event) {
          final shopList = event.map((list) => list
              .map((e) => Shop(
                  name: e.name,
                  shopId: e.shopId,
                  latitude: e.latitude,
                  longitude: e.longitude,
                  comment: e.comment,
                  images: e.images,
                  serviceTags: e.serviceTags,
                  areaTags: e.areaTags,
                  foodTags: e.foodTags,
                  postUser: e.postUser,
                  price: e.price))
              .toList());

          _shopRepositoryStreamController.add(shopList);
        });

        return Success('SUCCESS');
      },
      (e) => Error(Exception(e)),
    );
  }
}
