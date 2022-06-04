import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_model.freezed.dart';

part 'menu_model.g.dart';

@freezed
class MenuModel with _$MenuModel {
  factory MenuModel({
    required String name,
    required String shopId,
    required List<String> images,
    required List<int> foodTags,
    required int price,
    required String review,
  }) = _MenuModel;

  const MenuModel._();

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);
}