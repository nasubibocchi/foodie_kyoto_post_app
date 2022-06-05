// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MenuModel _$$_MenuModelFromJson(Map<String, dynamic> json) => _$_MenuModel(
      name: json['name'] as String,
      shopId: json['shop_id'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      movies:
          (json['movies'] as List<dynamic>).map((e) => e as String).toList(),
      foodTags:
          (json['food_tags'] as List<dynamic>).map((e) => e as int).toList(),
      price: json['price'] as int,
      review: json['review'] as String,
      postUser: json['post_user'] as String,
    );

Map<String, dynamic> _$$_MenuModelToJson(_$_MenuModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'shop_id': instance.shopId,
      'images': instance.images,
      'movies': instance.movies,
      'food_tags': instance.foodTags,
      'price': instance.price,
      'review': instance.review,
      'post_user': instance.postUser,
    };
