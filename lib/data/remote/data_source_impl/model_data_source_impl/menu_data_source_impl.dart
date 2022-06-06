import 'package:foodie_kyoto_post_app/data/model/menu_model.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/menu_data_source.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/firestore_data_source_impl/menu_firestore.dart';

class MenuDataSourceImpl implements MenuDataSource {
  MenuDataSourceImpl({required MenuFirestore menuFirestore})
      : _menuFirestore = menuFirestore;

  final MenuFirestore _menuFirestore;

  @override
  Future<Result<MenuModel>> createMenu({required MenuModel menuModel}) async {
    final menuData = menuModel.toJson();

    final firestoreResult = await _menuFirestore.createMenu(menuData: menuData);

    return firestoreResult.whenWithResult(
      (result) => Success(MenuModel.fromJson(result.value)),
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<List<MenuModel>>> fetchShopMenus(
      {required String shopId}) async {
    final menusResult = await _menuFirestore.fetchShopMenus(shopId: shopId);

    return menusResult.whenWithResult(
      (snapshot) {
        if (snapshot.value.docs.isNotEmpty) {
          final menuList = snapshot.value.docs
              .map((e) => MenuModel.fromJson(e.data()))
              .toList();
          return Success(menuList);
        } else {
          return Success(<MenuModel>[]);
        }
      },
      (e) => Error(Exception(e)),
    );
  }
}
