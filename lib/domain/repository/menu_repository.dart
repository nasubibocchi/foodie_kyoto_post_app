import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/menu_data_source.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/menu_repository_impl.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuRepositoryProvider = Provider<MenuRepositoryImpl>(
    (ref) => MenuRepositoryImpl(dataSource: ref.read(menuDataSourceProvider)));

abstract class MenuRepository {
  Future<Result<Menu>> createMenu({required Menu menu});
}
