// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'menu_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MenuModel _$MenuModelFromJson(Map<String, dynamic> json) {
  return _MenuModel.fromJson(json);
}

/// @nodoc
mixin _$MenuModel {
  String get name => throw _privateConstructorUsedError;
  String get shopId => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  List<String> get movies => throw _privateConstructorUsedError;
  List<int> get foodTags => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  String get review => throw _privateConstructorUsedError;
  String get postUser => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MenuModelCopyWith<MenuModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuModelCopyWith<$Res> {
  factory $MenuModelCopyWith(MenuModel value, $Res Function(MenuModel) then) =
      _$MenuModelCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String shopId,
      List<String> images,
      List<String> movies,
      List<int> foodTags,
      int price,
      String review,
      String postUser});
}

/// @nodoc
class _$MenuModelCopyWithImpl<$Res> implements $MenuModelCopyWith<$Res> {
  _$MenuModelCopyWithImpl(this._value, this._then);

  final MenuModel _value;
  // ignore: unused_field
  final $Res Function(MenuModel) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? shopId = freezed,
    Object? images = freezed,
    Object? movies = freezed,
    Object? foodTags = freezed,
    Object? price = freezed,
    Object? review = freezed,
    Object? postUser = freezed,
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
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      movies: movies == freezed
          ? _value.movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      foodTags: foodTags == freezed
          ? _value.foodTags
          : foodTags // ignore: cast_nullable_to_non_nullable
              as List<int>,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      review: review == freezed
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String,
      postUser: postUser == freezed
          ? _value.postUser
          : postUser // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_MenuModelCopyWith<$Res> implements $MenuModelCopyWith<$Res> {
  factory _$$_MenuModelCopyWith(
          _$_MenuModel value, $Res Function(_$_MenuModel) then) =
      __$$_MenuModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String shopId,
      List<String> images,
      List<String> movies,
      List<int> foodTags,
      int price,
      String review,
      String postUser});
}

/// @nodoc
class __$$_MenuModelCopyWithImpl<$Res> extends _$MenuModelCopyWithImpl<$Res>
    implements _$$_MenuModelCopyWith<$Res> {
  __$$_MenuModelCopyWithImpl(
      _$_MenuModel _value, $Res Function(_$_MenuModel) _then)
      : super(_value, (v) => _then(v as _$_MenuModel));

  @override
  _$_MenuModel get _value => super._value as _$_MenuModel;

  @override
  $Res call({
    Object? name = freezed,
    Object? shopId = freezed,
    Object? images = freezed,
    Object? movies = freezed,
    Object? foodTags = freezed,
    Object? price = freezed,
    Object? review = freezed,
    Object? postUser = freezed,
  }) {
    return _then(_$_MenuModel(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      shopId: shopId == freezed
          ? _value.shopId
          : shopId // ignore: cast_nullable_to_non_nullable
              as String,
      images: images == freezed
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      movies: movies == freezed
          ? _value._movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      foodTags: foodTags == freezed
          ? _value._foodTags
          : foodTags // ignore: cast_nullable_to_non_nullable
              as List<int>,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      review: review == freezed
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String,
      postUser: postUser == freezed
          ? _value.postUser
          : postUser // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MenuModel extends _MenuModel {
  _$_MenuModel(
      {required this.name,
      required this.shopId,
      required final List<String> images,
      required final List<String> movies,
      required final List<int> foodTags,
      required this.price,
      required this.review,
      required this.postUser})
      : _images = images,
        _movies = movies,
        _foodTags = foodTags,
        super._();

  factory _$_MenuModel.fromJson(Map<String, dynamic> json) =>
      _$$_MenuModelFromJson(json);

  @override
  final String name;
  @override
  final String shopId;
  final List<String> _images;
  @override
  List<String> get images {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<String> _movies;
  @override
  List<String> get movies {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movies);
  }

  final List<int> _foodTags;
  @override
  List<int> get foodTags {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodTags);
  }

  @override
  final int price;
  @override
  final String review;
  @override
  final String postUser;

  @override
  String toString() {
    return 'MenuModel(name: $name, shopId: $shopId, images: $images, movies: $movies, foodTags: $foodTags, price: $price, review: $review, postUser: $postUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MenuModel &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.shopId, shopId) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._movies, _movies) &&
            const DeepCollectionEquality().equals(other._foodTags, _foodTags) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.review, review) &&
            const DeepCollectionEquality().equals(other.postUser, postUser));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(shopId),
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_movies),
      const DeepCollectionEquality().hash(_foodTags),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(review),
      const DeepCollectionEquality().hash(postUser));

  @JsonKey(ignore: true)
  @override
  _$$_MenuModelCopyWith<_$_MenuModel> get copyWith =>
      __$$_MenuModelCopyWithImpl<_$_MenuModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MenuModelToJson(this);
  }
}

abstract class _MenuModel extends MenuModel {
  factory _MenuModel(
      {required final String name,
      required final String shopId,
      required final List<String> images,
      required final List<String> movies,
      required final List<int> foodTags,
      required final int price,
      required final String review,
      required final String postUser}) = _$_MenuModel;
  _MenuModel._() : super._();

  factory _MenuModel.fromJson(Map<String, dynamic> json) =
      _$_MenuModel.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get shopId => throw _privateConstructorUsedError;
  @override
  List<String> get images => throw _privateConstructorUsedError;
  @override
  List<String> get movies => throw _privateConstructorUsedError;
  @override
  List<int> get foodTags => throw _privateConstructorUsedError;
  @override
  int get price => throw _privateConstructorUsedError;
  @override
  String get review => throw _privateConstructorUsedError;
  @override
  String get postUser => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MenuModelCopyWith<_$_MenuModel> get copyWith =>
      throw _privateConstructorUsedError;
}
