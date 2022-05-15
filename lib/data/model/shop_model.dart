import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class ShopModel {
  const ShopModel(
      {required this.name,
      required this.shopId,
      required this.latitude,
      required this.longitude,
      required this.comment,
      required this.images,
      required this.tags,
      required this.postUser});

  factory ShopModel.fromJson(Map<String, Object?> json) {
    final position = json['position'] as Map<String, dynamic>;
    final geoPoint = position['geopoint'];

    final dynamicImages = json['images'] as List<dynamic>;
    final images = dynamicImages.cast<String>();

    final dynamicTags = json['tags'] as List<dynamic>;
    final tags = dynamicTags.cast<int>();

    return ShopModel(
        name: json['name'] as String,
        shopId: json['shop_id'] as String,
        latitude: geoPoint['latitude'] as double,
        longitude: geoPoint['longitude'] as double,
        comment: json['comment'] as String,
        images: images,
        tags: tags,
        postUser: json['post_user'] as String);
  }

  final String name;
  final String shopId;
  final double latitude;
  final double longitude;
  final String comment;
  final List<String> images;
  final List<int> tags;
  final String postUser;

  ShopModel copyWith(
      {String? name,
      String? shopId,
      double? latitude,
      double? longitude,
      String? comment,
      List<String>? images,
      List<int>? tags,
      String? postUser}) {
    return ShopModel(
        name: name as String,
        shopId: shopId as String,
        latitude: latitude as double,
        longitude: longitude as double,
        comment: comment as String,
        images: images as List<String>,
        tags: tags as List<int>,
        postUser: postUser as String);
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'shop_id': shopId,
      'latitude': latitude,
      'longitude': longitude,
      'comment': comment,
      'images': images,
      'tags': tags,
      'post_user': postUser,
    };
  }

  @override
  String toString() {
    return 'ShopModel('
        'name: $name,'
        'shop_id: $shopId,'
        'latitude: $latitude,'
        'longitude: $longitude,'
        'comment: $comment,'
        'images: $images,'
        'tags: $tags,'
        'post_user: $postUser,'
        ')';
  }

  @override
  bool operator ==(Object other) => identical(ShopModel, other);

  @override
  int get hashCode {
    return Object.hash(runtimeType, name, shopId, latitude, longitude, comment,
        images, tags, postUser);
  }
}
