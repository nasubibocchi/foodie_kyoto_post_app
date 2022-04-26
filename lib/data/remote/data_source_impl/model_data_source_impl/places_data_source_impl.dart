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
  Future<Result<List<String>>> searchShopsByAutoComplete(
      {required String body}) async {
    try {
      final response = await places.autocomplete(body);
      List<String> searchResultList = [];
      for (Prediction p in response.predictions) {
        searchResultList.add('${p.description}');
      }
      return Success(searchResultList);
    } on Exception catch (e) {
      return Error(Exception(e));
    }
  }
}
