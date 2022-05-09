import 'package:foodie_kyoto_post_app/data/model/foodie_location_model.dart';
import 'package:foodie_kyoto_post_app/data/model/foodie_prediction_model.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/model_data_source_impl/places_data_source_impl.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final placesDataSourceProvider =
    Provider<PlacesDataSource>((ref) => PlacesDataSourceImpl());

abstract class PlacesDataSource {
  late final GoogleMapsPlaces places;

  void initGooglePlaces({required String apiKey});

  Future<Result<List<FoodiePredictionModel>>> searchShopsByAutoComplete(
      {required String body});

  Future<Result<FoodieLocationModel?>> searchShopDetailByPlaceId(
      {required String placeId});
}
