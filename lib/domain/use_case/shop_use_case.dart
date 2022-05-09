import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/domain/repository/shop_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final shopUseCaseProvider = Provider<ShopUseCase>(
    (ref) => ShopUseCase(repository: ref.read(shopRepositoryProvider)));

class ShopUseCase {
  ShopUseCase({required ShopRepository repository}) : _repository = repository;

  final ShopRepository _repository;

  Future<Result<List<Shop>>> fetchShops({required int limit, String? cursor}) =>
      _repository.fetchShops(limit: limit, cursor: cursor);

  Future<Result<void>> postShop({required Shop shop}) =>
      _repository.postShop(shop: shop);

  Future<Result<Shop?>> fetchShopByShopId({required String shopId}) =>
      _repository.fetchShopByShopId(shopId: shopId);
}
