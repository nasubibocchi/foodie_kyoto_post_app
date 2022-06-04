import 'package:foodie_kyoto_post_app/data/model/menu_model.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/menu_data_source.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/repository/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl({required MenuDataSource dataSource})
      : _dataSource = dataSource;

  final MenuDataSource _dataSource;

  @override
  Future<Result<Menu>> createMenu({required Menu menu}) async {
    final menuModel = MenuModel(
        name: menu.name,
        shopId: menu.shopId,
        images: menu.images,
        foodTags: menu.foodTags,
        price: menu.price,
        review: menu.review);

    final menuModelResult = await _dataSource.createMenu(menuModel: menuModel);

    return menuModelResult.whenWithResult(
      (menuModel) => Success(
        Menu(
            name: menuModel.value.name,
            shopId: menuModel.value.shopId,
            images: menuModel.value.images,
            foodTags: menuModel.value.foodTags,
            price: menuModel.value.price,
            review: menuModel.value.review),
      ),
      (e) => Error(Exception(e)),
    );
  }
}
