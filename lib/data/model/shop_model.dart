import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_model.freezed.dart';

part 'shop_model.g.dart';

@freezed
class ShopModel with _$ShopModel {
  const factory ShopModel({
    required String name,
    required String shopId,
    required dynamic position,
    required String comment,
    required List<String> images,
    required List<int> tags,
  }) = _AppShop;

  const ShopModel._();

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);
}
