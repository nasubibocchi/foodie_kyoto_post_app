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
  Future<Result<Menu>> postMenu({required Menu menu}) async {
    final menuModel = MenuModel(
        menuId: menu.menuId,
        name: menu.name,
        shopId: menu.shopId,
        images: menu.images,
        movies: menu.movies,
        foodTags: menu.foodTags,
        price: menu.price,
        review: menu.review,
        enReview: menu.enReview,
        postUser: menu.postUser);

    final menuModelResult = await _dataSource.postMenu(menuModel: menuModel);

    return menuModelResult.whenWithResult(
      (menuModel) => Success(
        Menu(
            menuId: menuModel.value.menuId,
            name: menuModel.value.name,
            shopId: menuModel.value.shopId,
            images: menuModel.value.images,
            movies: menuModel.value.movies,
            foodTags: menuModel.value.foodTags,
            price: menuModel.value.price,
            review: menuModel.value.review,
            enReview: menuModel.value.enReview,
            postUser: menuModel.value.postUser),
      ),
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<List<Menu>>> fetchShopMenus({required String shopId}) async {
    final menuModelResult = await _dataSource.fetchShopMenus(shopId: shopId);

    return menuModelResult.whenWithResult(
      (menuModelList) {
        if (menuModelList.value.isNotEmpty) {
          final menuList = menuModelList.value
              .map((e) => Menu(
                  menuId: e.menuId,
                  name: e.name,
                  shopId: e.shopId,
                  images: e.images,
                  movies: e.movies,
                  foodTags: e.foodTags,
                  price: e.price,
                  review: e.review,
                  enReview: e.enReview,
                  postUser: e.postUser))
              .toList();
          return Success(menuList);
        } else {
          return Success(<Menu>[]);
        }
      },
      (e) => Error(Exception(e)),
    );
  }
}
