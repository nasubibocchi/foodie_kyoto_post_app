import 'package:freezed_annotation/freezed_annotation.dart';

part 'foodie_location_model.freezed.dart';

part 'foodie_location_model.g.dart';

@freezed
class FoodieLocation with _$FoodieLocation {
  factory FoodieLocation(
      {required double latitude, required double longitude}) = _FoodieLocation;

  const FoodieLocation._();

  factory FoodieLocation.fromJson(Map<String, dynamic> json) =>
      _$FoodieLocationFromJson(json);
}
