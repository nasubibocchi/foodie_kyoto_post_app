// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'shop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShopModel _$ShopModelFromJson(Map<String, dynamic> json) {
  return _AppShop.fromJson(json);
}

/// @nodoc
mixin _$ShopModel {
  String get name => throw _privateConstructorUsedError;
  String get shopId => throw _privateConstructorUsedError;
  dynamic get position => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  List<int> get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShopModelCopyWith<ShopModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopModelCopyWith<$Res> {
  factory $ShopModelCopyWith(ShopModel value, $Res Function(ShopModel) then) =
      _$ShopModelCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String shopId,
      dynamic position,
      String comment,
      List<String> images,
      List<int> tags});
}

/// @nodoc
class _$ShopModelCopyWithImpl<$Res> implements $ShopModelCopyWith<$Res> {
  _$ShopModelCopyWithImpl(this._value, this._then);

  final ShopModel _value;
  // ignore: unused_field
  final $Res Function(ShopModel) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? shopId = freezed,
    Object? position = freezed,
    Object? comment = freezed,
    Object? images = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      shopId: shopId == freezed
          ? _value.shopId
          : shopId // ignore: cast_nullable_to_non_nullable
              as String,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as dynamic,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
abstract class _$AppShopCopyWith<$Res> implements $ShopModelCopyWith<$Res> {
  factory _$AppShopCopyWith(_AppShop value, $Res Function(_AppShop) then) =
      __$AppShopCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String shopId,
      dynamic position,
      String comment,
      List<String> images,
      List<int> tags});
}

/// @nodoc
class __$AppShopCopyWithImpl<$Res> extends _$ShopModelCopyWithImpl<$Res>
    implements _$AppShopCopyWith<$Res> {
  __$AppShopCopyWithImpl(_AppShop _value, $Res Function(_AppShop) _then)
      : super(_value, (v) => _then(v as _AppShop));

  @override
  _AppShop get _value => super._value as _AppShop;

  @override
  $Res call({
    Object? name = freezed,
    Object? shopId = freezed,
    Object? position = freezed,
    Object? comment = freezed,
    Object? images = freezed,
    Object? tags = freezed,
  }) {
    return _then(_AppShop(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      shopId: shopId == freezed
          ? _value.shopId
          : shopId // ignore: cast_nullable_to_non_nullable
              as String,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as dynamic,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppShop extends _AppShop {
  const _$_AppShop(
      {required this.name,
      required this.shopId,
      required this.position,
      required this.comment,
      required final List<String> images,
      required final List<int> tags})
      : _images = images,
        _tags = tags,
        super._();

  factory _$_AppShop.fromJson(Map<String, dynamic> json) =>
      _$$_AppShopFromJson(json);

  @override
  final String name;
  @override
  final String shopId;
  @override
  final dynamic position;
  @override
  final String comment;
  final List<String> _images;
  @override
  List<String> get images {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<int> _tags;
  @override
  List<int> get tags {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'ShopModel(name: $name, shopId: $shopId, position: $position, comment: $comment, images: $images, tags: $tags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppShop &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.shopId, shopId) &&
            const DeepCollectionEquality().equals(other.position, position) &&
            const DeepCollectionEquality().equals(other.comment, comment) &&
            const DeepCollectionEquality().equals(other.images, images) &&
            const DeepCollectionEquality().equals(other.tags, tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(shopId),
      const DeepCollectionEquality().hash(position),
      const DeepCollectionEquality().hash(comment),
      const DeepCollectionEquality().hash(images),
      const DeepCollectionEquality().hash(tags));

  @JsonKey(ignore: true)
  @override
  _$AppShopCopyWith<_AppShop> get copyWith =>
      __$AppShopCopyWithImpl<_AppShop>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppShopToJson(this);
  }
}

abstract class _AppShop extends ShopModel {
  const factory _AppShop(
      {required final String name,
      required final String shopId,
      required final dynamic position,
      required final String comment,
      required final List<String> images,
      required final List<int> tags}) = _$_AppShop;
  const _AppShop._() : super._();

  factory _AppShop.fromJson(Map<String, dynamic> json) = _$_AppShop.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get shopId => throw _privateConstructorUsedError;
  @override
  dynamic get position => throw _privateConstructorUsedError;
  @override
  String get comment => throw _privateConstructorUsedError;
  @override
  List<String> get images => throw _privateConstructorUsedError;
  @override
  List<int> get tags => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AppShopCopyWith<_AppShop> get copyWith =>
      throw _privateConstructorUsedError;
}
