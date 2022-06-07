import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/repository/menu_movie_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuMovieUseCase = Provider<MenuMovieUseCase>((ref) =>
    MenuMovieUseCase(repository: ref.read(menuMovieRepositoryProvider)));

class MenuMovieUseCase {
  MenuMovieUseCase({required MenuMovieRepository repository})
      : _repository = repository;

  final MenuMovieRepository _repository;

  Future<Result<String?>> postMovie(
          {required String path,
          required String shopId,
          required String menuName,
          required String fileName}) =>
      _repository.postMovie(
          path: path, shopId: shopId, menuName: menuName, fileName: fileName);

  Future<Result<String?>> getMovieUrl(
          {required String path,
          required String shopId,
          required String menuName,
          required String fileName}) =>
      _repository.getMovieUrl(
          path: path, shopId: shopId, menuName: menuName, fileName: fileName);

  Future<Result<String>> deleteMovies(
          {required String shopId, required menuName}) =>
      _repository.deleteMovies(shopId: shopId, menuName: menuName);
}
