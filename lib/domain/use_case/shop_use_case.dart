import 'dart:async';

import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/domain/repository/shop_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final shopUseCaseProvider = Provider<ShopUseCase>(
    (ref) => ShopUseCase(repository: ref.read(shopRepositoryProvider)));

class ShopUseCase {
  ShopUseCase({required ShopRepository repository}) : _repository = repository;

  final ShopRepository _repository;
  final shopUseCaseStreamController = StreamController<Stream<List<Shop>>>();

  Future<Result<List<Shop>>> fetchShops({required int limit, String? cursor}) =>
      _repository.fetchShops(limit: limit, cursor: cursor);

  Future<Result<void>> postShop({required Shop shop}) =>
      _repository.postShop(shop: shop);

  Future<Result<Shop?>> fetchShopByShopId({required String shopId}) =>
      _repository.fetchShopByShopId(shopId: shopId);

  Future<Result<String>> fetchShopInMapStream(
      {required double latitude,
      required double longitude,
      required radius}) async {
    final result = await _repository.fetchShopInMapStream(
        latitude: latitude, longitude: longitude, radius: radius);

    return result.whenWithResult(
      (success) {
        _repository.shopRepositoryStreamController?.stream.listen((event) {
          shopUseCaseStreamController.add(event);
        });

        return Success('SUCCESS');
      },
      (e) => Error(Exception(e)),
    );
  }
}
