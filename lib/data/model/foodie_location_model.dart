import 'package:freezed_annotation/freezed_annotation.dart';

part 'foodie_location_model.freezed.dart';

part 'foodie_location_model.g.dart';

@freezed
class FoodieLocationModel with _$FoodieLocationModel {
  factory FoodieLocationModel(
      {required double latitude,
      required double longitude}) = _FoodieLocationModel;

  const FoodieLocationModel._();

  factory FoodieLocationModel.fromJson(Map<String, dynamic> json) =>
      _$FoodieLocationModelFromJson(json);
}
