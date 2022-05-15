import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/places_data_source.dart';
import 'package:foodie_kyoto_post_app/domain/entity/foodie_prediction.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop_detail.dart';
import 'package:foodie_kyoto_post_app/domain/repository/places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  PlacesRepositoryImpl({required PlacesDataSource dataSource})
      : _dataSource = dataSource;

  final PlacesDataSource _dataSource;

  @override
  void initGooglePlaces({required String apiKey}) =>
      _dataSource.initGooglePlaces(apiKey: apiKey);

  @override
  Future<Result<List<FoodiePrediction>>> searchShopsByAutoComplete(
      {required String body}) async {
    final predictionModelList =
        await _dataSource.searchShopsByAutoComplete(body: body);
    return predictionModelList.whenWithResult(
      (list) => Success(list.value
          .map((e) =>
              FoodiePrediction(description: e.description, placeId: e.placeId))
          .toList()),
      (e) => Error(Exception(e)),
    );
  }

  @override
  Future<Result<ShopDetail?>> searchShopDetailsByPlaceId(
      {required String placeId}) async {
    final placesDetailResponse =
        await _dataSource.searchShopDetailsByPlaceId(placeId: placeId);

    return placesDetailResponse.whenWithResult(
      (response) {
        final latitude = response.value?.latitude;
        final longitude = response.value?.longitude;
        final shopName = response.value?.name ?? '';

        if (latitude != null && longitude != null) {
          final location = ShopDetail(
              name: shopName, latitude: latitude, longitude: longitude);
          return Success(location);
        } else {
          return Success(null);
        }
      },
      (e) => Error(Exception(e)),
    );
  }
}
