// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'shop_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShopDetailModel _$ShopDetailModelFromJson(Map<String, dynamic> json) {
  return _ShopDetailModel.fromJson(json);
}

/// @nodoc
mixin _$ShopDetailModel {
  String get name => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShopDetailModelCopyWith<ShopDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopDetailModelCopyWith<$Res> {
  factory $ShopDetailModelCopyWith(
          ShopDetailModel value, $Res Function(ShopDetailModel) then) =
      _$ShopDetailModelCopyWithImpl<$Res>;
  $Res call({String name, double latitude, double longitude});
}

/// @nodoc
class _$ShopDetailModelCopyWithImpl<$Res>
    implements $ShopDetailModelCopyWith<$Res> {
  _$ShopDetailModelCopyWithImpl(this._value, this._then);

  final ShopDetailModel _value;
  // ignore: unused_field
  final $Res Function(ShopDetailModel) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_ShopDetailModelCopyWith<$Res>
    implements $ShopDetailModelCopyWith<$Res> {
  factory _$$_ShopDetailModelCopyWith(
          _$_ShopDetailModel value, $Res Function(_$_ShopDetailModel) then) =
      __$$_ShopDetailModelCopyWithImpl<$Res>;
  @override
  $Res call({String name, double latitude, double longitude});
}

/// @nodoc
class __$$_ShopDetailModelCopyWithImpl<$Res>
    extends _$ShopDetailModelCopyWithImpl<$Res>
    implements _$$_ShopDetailModelCopyWith<$Res> {
  __$$_ShopDetailModelCopyWithImpl(
      _$_ShopDetailModel _value, $Res Function(_$_ShopDetailModel) _then)
      : super(_value, (v) => _then(v as _$_ShopDetailModel));

  @override
  _$_ShopDetailModel get _value => super._value as _$_ShopDetailModel;

  @override
  $Res call({
    Object? name = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$_ShopDetailModel(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShopDetailModel extends _ShopDetailModel {
  _$_ShopDetailModel(
      {required this.name, required this.latitude, required this.longitude})
      : super._();

  factory _$_ShopDetailModel.fromJson(Map<String, dynamic> json) =>
      _$$_ShopDetailModelFromJson(json);

  @override
  final String name;
  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'ShopDetailModel(name: $name, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShopDetailModel &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.latitude, latitude) &&
            const DeepCollectionEquality().equals(other.longitude, longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(latitude),
      const DeepCollectionEquality().hash(longitude));

  @JsonKey(ignore: true)
  @override
  _$$_ShopDetailModelCopyWith<_$_ShopDetailModel> get copyWith =>
      __$$_ShopDetailModelCopyWithImpl<_$_ShopDetailModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShopDetailModelToJson(this);
  }
}

abstract class _ShopDetailModel extends ShopDetailModel {
  factory _ShopDetailModel(
      {required final String name,
      required final double latitude,
      required final double longitude}) = _$_ShopDetailModel;
  _ShopDetailModel._() : super._();

  factory _ShopDetailModel.fromJson(Map<String, dynamic> json) =
      _$_ShopDetailModel.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  double get latitude => throw _privateConstructorUsedError;
  @override
  double get longitude => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ShopDetailModelCopyWith<_$_ShopDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}
