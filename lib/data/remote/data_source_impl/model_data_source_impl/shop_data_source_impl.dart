import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/model/shop_model.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/shop_data_source.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/firestore_data_source_impl/shop_firestore.dart';

class ShopDataSourceImpl implements ShopDataSource {
  ShopDataSourceImpl({required ShopFirestore shopFirestore})
      : _shopFirestore = shopFirestore;
  final ShopFirestore _shopFirestore;

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
  Future<Result<List<ShopModel>>> fetchShopsInMap(
      {required List<String> shopIdList}) async {
    final snapshotResult =
        await _shopFirestore.fetchShopsInMap(shopIdList: shopIdList);

    // docsのfirstをとっているのは、Listの要素であるQuerySnapshotが一つしかデータを持たない
    // (=同じshopIdが存在しない)想定のため。
    return snapshotResult.whenWithResult(
        (snapshotList) => Success(snapshotList.value
            .map((e) => ShopModel.fromJson(e.docs.first.data()))
            .toList()),
        (e) => Error(Exception(e)));
  }
}
