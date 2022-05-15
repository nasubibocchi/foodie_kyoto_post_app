import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_detail_model.freezed.dart';

part 'shop_detail_model.g.dart';

@freezed
class ShopDetailModel with _$ShopDetailModel {
  factory ShopDetailModel(
      {required String name,
      required double latitude,
      required double longitude}) = _ShopDetailModel;

  const ShopDetailModel._();

  factory ShopDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ShopDetailModelFromJson(json);
}
