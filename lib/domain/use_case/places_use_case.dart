import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/repository/places_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final placesUseCaseProvider = Provider<PlacesUseCase>(
    (ref) => PlacesUseCase(repository: ref.read(placesRepositoryProvider)));

class PlacesUseCase {
  PlacesUseCase({required PlacesRepository repository})
      : _repository = repository;

  final PlacesRepository _repository;

  void initGooglePlaces({required String apiKey}) =>
      _repository.initGooglePlaces(apiKey: apiKey);

  Future<Result<List<String>>> searchShopsByAutoComplete(
          {required String body}) =>
      _repository.searchShopsByAutoComplete(body: body);
}
