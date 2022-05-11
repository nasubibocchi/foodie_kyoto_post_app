// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TagModel _$$_TagModelFromJson(Map<String, dynamic> json) => _$_TagModel(
      id: json['id'] as int,
      name: json['name'] as String,
      shopIdList: (json['shop_id_list'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_TagModelToJson(_$_TagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shop_id_list': instance.shopIdList,
    };
