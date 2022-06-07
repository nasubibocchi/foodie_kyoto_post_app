import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/repository/menu_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuUseCaseProvider = Provider<MenuUseCase>(
    (ref) => MenuUseCase(repository: ref.read(menuRepositoryProvider)));

class MenuUseCase {
  MenuUseCase({required MenuRepository repository}) : _repository = repository;

  final MenuRepository _repository;

  Future<Result<Menu>> postMenu({required Menu menu}) =>
      _repository.postMenu(menu: menu);

  Future<Result<List<Menu>>> fetchShopMenus({required String shopId}) =>
      _repository.fetchShopMenus(shopId: shopId);
}
