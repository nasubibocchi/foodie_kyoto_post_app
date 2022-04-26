import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/places_data_source.dart';
import 'package:foodie_kyoto_post_app/domain/repository/places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  PlacesRepositoryImpl({required PlacesDataSource dataSource})
      : _dataSource = dataSource;

  final PlacesDataSource _dataSource;

  @override
  void initGooglePlaces({required String apiKey}) =>
      _dataSource.initGooglePlaces(apiKey: apiKey);

  @override
  Future<Result<List<String>>> searchShopsByAutoComplete(
          {required String body}) async =>
      await _dataSource.searchShopsByAutoComplete(body: body);
}
