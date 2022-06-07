import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/menu_movie_data_source.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/menu_movie_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuMovieRepositoryProvider = Provider<MenuMovieRepositoryImpl>((ref) =>
    MenuMovieRepositoryImpl(dataSource: ref.read(menuMovieDataSourceProvider)));

abstract class MenuMovieRepository {
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
