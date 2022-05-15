import 'package:foodie_kyoto_post_app/data/model/foodie_location_model.dart';
import 'package:foodie_kyoto_post_app/data/model/foodie_prediction_model.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/places_data_source.dart';
import 'package:google_maps_webservice/places.dart';

class PlacesDataSourceImpl implements PlacesDataSource {
  @override
  late final GoogleMapsPlaces places;

  @override
  void initGooglePlaces({required String apiKey}) {
    places = GoogleMapsPlaces(apiKey: apiKey);
  }

  @override
  Future<Result<List<FoodiePredictionModel>>> searchShopsByAutoComplete(
      {required String body}) async {
    try {
      final response = await places.autocomplete(body);
      List<Map<String, String?>> searchResultList = [];
      for (Prediction p in response.predictions) {
        searchResultList.add({
          'description': '${p.description}',
          'place_id': '${p.placeId}',
        });
      }
      final predictionList = searchResultList
          .map((e) => FoodiePredictionModel.fromJson(e))
          .toList();
      return Success(predictionList);
    } on Exception catch (e) {
      return Error(Exception(e));
    }
  }

  @override
  Future<Result<FoodieLocationModel?>> searchShopLocationByPlaceId(
      {required String placeId}) async {
    try {
      final placesDetailResponse = await places.getDetailsByPlaceId(placeId);

      final latitude = placesDetailResponse.result.geometry?.location.lat;
      final longitude = placesDetailResponse.result.geometry?.location.lng;

      if (latitude != null && longitude != null) {
        final foodieLocation =
            FoodieLocationModel(latitude: latitude, longitude: longitude);
        return Success(foodieLocation);
      } else {
        return Success(null);
      }
    } on Exception catch (e) {
      return Error(Exception(e));
    }
  }
}
