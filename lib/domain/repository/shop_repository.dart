import 'dart:async';

import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/shop_data_source.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/shop_repository_impl.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final shopRepositoryProvider = Provider<ShopRepositoryImpl>(
    (ref) => ShopRepositoryImpl(dataSource: ref.read(shopDataSourceProvider)));

abstract class ShopRepository {
  StreamController<Stream<List<Shop>>>? shopRepositoryStreamController;

  Future<Result<List<Shop>>> fetchShops({required int limit, String? cursor});

  Future<Result<void>> postShop({required Shop shop});

  Future<Result<Shop?>> fetchShopByShopId({required String shopId});

  Future<Result<String>> fetchShopInMapStream(
      {required double latitude, required double longitude, required radius});
}
