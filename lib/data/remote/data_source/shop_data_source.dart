import 'dart:async';

import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/model/shop_model.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/firestore_data_source_impl/shop_firestore.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/model_data_source_impl/shop_data_source_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final shopDataSourceProvider = Provider<ShopDataSourceImpl>((ref) =>
    ShopDataSourceImpl(shopFirestore: ref.read(shopFirestoreProvider)));

abstract class ShopDataSource {
  Future<Result<List<ShopModel>>> fetchShops(
      {required int limit, String? cursor});

  StreamController<Stream<List<ShopModel>>>? shopDataSourceStreamController;

  Future<Result<void>> postShop({required ShopModel shop});

  Future<Result<ShopModel?>> fetchShopByShopId({required String shopId});

  Future<Result<String>> fetchShopInMapStream(
      {required double latitude, required double longitude, required radius});
}
