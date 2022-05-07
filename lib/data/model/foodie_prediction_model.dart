import 'package:freezed_annotation/freezed_annotation.dart';

part 'foodie_prediction_model.freezed.dart';

part 'foodie_prediction_model.g.dart';

@freezed
class FoodiePredictionModel with _$FoodiePredictionModel {
  factory FoodiePredictionModel(
      {required String description,
      required String placeId}) = _FoodiePredictionModel;

  const FoodiePredictionModel._();

  factory FoodiePredictionModel.fromJson(Map<String, dynamic> json) =>
      _$FoodiePredictionModelFromJson(json);
}
