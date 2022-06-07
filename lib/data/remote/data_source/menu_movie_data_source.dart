import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/model_data_source_impl/menu_movie_data_source_impl.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/storage_data_source_impl/menu_movie_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuMovieDataSourceProvider = Provider<MenuMovieDataSourceImpl>((ref) =>
    MenuMovieDataSourceImpl(
        menuMovieStorage: ref.read(menuMovieStorageProvider)));

abstract class MenuMovieDataSource {
  Future<Result<String?>> postMovie(
      {required String path,
      required String shopId,
      required String menuName,
      required String fileName});

  Future<Result<String?>> getMovieUrl(
      {required String path,
      required String shopId,
      required String menuName,
      required String fileName});

  Future<Result<String>> deleteMovies(
      {required String shopId, required menuName});
}
