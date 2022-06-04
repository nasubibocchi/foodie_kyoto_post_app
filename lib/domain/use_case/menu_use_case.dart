import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/repository/menu_repository.dart';

class MenuUseCase {
  MenuUseCase({required MenuRepository repository}) : _repository = repository;

  final MenuRepository _repository;

  Future<Result<Menu>> createMenu({required Menu menu}) =>
      _repository.createMenu(menu: menu);
}
