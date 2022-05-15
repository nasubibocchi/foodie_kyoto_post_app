// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ShopDetailModel _$$_ShopDetailModelFromJson(Map<String, dynamic> json) =>
    _$_ShopDetailModel(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$_ShopDetailModelToJson(_$_ShopDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
