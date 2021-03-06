import 'dart:async';

import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/model/shop_model.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/shop_data_source.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/firestore_data_source_impl/shop_firestore.dart';

class ShopDataSourceImpl implements ShopDataSource {
  ShopDataSourceImpl({required ShopFirestore shopFirestore})
      : _shopFirestore = shopFirestore;
  final ShopFirestore _shopFirestore;

  @override
  get shopDataSourceStreamController => _shopDataSourceStreamController;

  final _shopDataSourceStreamController =
      StreamController<Stream<List<ShopModel>>>();

  @override
  set shopDataSourceStreamController(
          StreamController<Stream<List<ShopModel>>>?
              _shopDataSourceStreamController) =>
      _shopDataSourceStreamController;

  @override
  Future<Result<List<ShopModel>>> fetchShops(
      {required int limit, String? cursor}) async {
    final snapshotResult =
        await _shopFirestore.fetchShops(limit: limit, cursor: cursor);
    return snapshotResult.whenWithResult(
        (data) => Success(
            data.value.docs.map((e) => ShopModel.fromJson(e.data())).toList()),
        (e) => Error(Exception(e)));
  }

  @override
  Future<Result<void>> postShop({required ShopModel shop}) async {
    final shopData = shop.toJson();
    final postResult = await _shopFirestore.postShop(shopData: shopData);

    return postResult.whenWithResult(
      (success) => Success(null),
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<ShopModel?>> fetchShopByShopId({required String shopId}) async {
    final shopResult = await _shopFirestore.fetchShopByShopId(shopId: shopId);

    return shopResult.whenWithResult(
      (shop) {
        if (shop.value != null && shop.value!.docs.isNotEmpty) {
          return Success(shop.value?.docs
              .map((e) => ShopModel.fromJson(e.data()))
              .toList()
              .first);
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
    final shopResult = await _shopFirestore.fetchShopInMapStream(
        latitude: latitude, longitude: longitude, radius: radius);

    return shopResult.whenWithResult(
      (success) {
        _shopFirestore.shopFirestoreStreamController.stream.listen((event) {
          final shopModel = event.map((list) =>
              list.map((e) => ShopModel.fromJson(e.data()!)).toList());

          _shopDataSourceStreamController.add(shopModel);
        });

        return Success('SUCCESS');
      },
      (e) => Error(Exception(e)),
    );
  }
}
