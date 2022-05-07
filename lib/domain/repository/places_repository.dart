import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/places_data_source.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/places_repository_impl.dart';
import 'package:foodie_kyoto_post_app/domain/entity/foodie_prediction.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final placesRepositoryProvider = Provider<PlacesRepository>((ref) =>
    PlacesRepositoryImpl(dataSource: ref.read(placesDataSourceProvider)));

abstract class PlacesRepository {
  void initGooglePlaces({required String apiKey});

  Future<Result<List<FoodiePrediction>>> searchShopsByAutoComplete(
      {required String body});
}
