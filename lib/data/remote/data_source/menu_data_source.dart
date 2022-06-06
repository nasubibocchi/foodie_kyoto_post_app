import 'package:foodie_kyoto_post_app/data/model/menu_model.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/firestore_data_source_impl/menu_firestore.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/model_data_source_impl/menu_data_source_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuDataSourceProvider = Provider<MenuDataSourceImpl>((ref) =>
    MenuDataSourceImpl(menuFirestore: ref.read(menuFirestoreProvider)));

abstract class MenuDataSource {
  Future<Result<MenuModel>> createMenu({required MenuModel menuModel});

  Future<Result<List<MenuModel>>> fetchShopMenus({required String shopId});
}
