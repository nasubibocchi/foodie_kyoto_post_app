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
}
