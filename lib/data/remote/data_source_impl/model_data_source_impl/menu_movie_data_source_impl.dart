import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/menu_movie_data_source.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/storage_data_source_impl/menu_movie_storage.dart';

class MenuMovieDataSourceImpl implements MenuMovieDataSource {
  MenuMovieDataSourceImpl({required MenuMovieStorage menuMovieStorage})
      : _menuMovieStorage = menuMovieStorage;

  final MenuMovieStorage _menuMovieStorage;

  @override
  Future<Result<String?>> postMovie(
      {required String path,
      required String shopId,
      required String menuName,
      required String fileName}) async {
    final storageResult = await _menuMovieStorage.postMovie(
        path: path, shopId: shopId, menuName: menuName, fileName: fileName);

    return storageResult.whenWithResult(
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
    final storageResult = await _menuMovieStorage.getMovieUrl(
        path: path, shopId: shopId, menuName: menuName, fileName: fileName);

    return storageResult.whenWithResult(
      (url) => Success(url.value),
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<String>> deleteMovies(
      {required String shopId, required menuName}) async {
    final storageResult = await _menuMovieStorage.deleteMovies(
        shopId: shopId, menuName: menuName);

    return storageResult.whenWithResult(
      (path) => Success(path.value),
      (e) => Error(Exception(e)),
    );
  }
}
