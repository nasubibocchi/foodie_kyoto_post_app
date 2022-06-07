import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/menu_movie_data_source.dart';
import 'package:foodie_kyoto_post_app/domain/repository/menu_movie_repository.dart';

class MenuMovieRepositoryImpl implements MenuMovieRepository {
  MenuMovieRepositoryImpl({required MenuMovieDataSource dataSource})
      : _dataSource = dataSource;

  final MenuMovieDataSource _dataSource;

  @override
  Future<Result<String?>> postMovie(
      {required String path,
      required String shopId,
      required String menuName,
      required String fileName}) async {
    final dataSourceResult = await _dataSource.postMovie(
        path: path, shopId: shopId, menuName: menuName, fileName: fileName);

    return dataSourceResult.whenWithResult(
      (path) => Success(path.value),
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<String?>> getMovieUrl(
      {required String path,
      required String shopId,
      required String menuName,
      required String fileName}) async {
    final dataSourceResult = await _dataSource.getMovieUrl(
        path: path, shopId: shopId, menuName: menuName, fileName: fileName);

    return dataSourceResult.whenWithResult(
      (url) => Success(url.value),
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<String>> deleteMovies(
      {required String shopId, required menuName}) async {
    final dataSourceResult =
        await _dataSource.deleteMovies(shopId: shopId, menuName: menuName);

    return dataSourceResult.whenWithResult(
      (path) => Success(path.value),
      (e) => Error(Exception(e)),
    );
  }
}
