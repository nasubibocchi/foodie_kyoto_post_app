// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'foodie_location_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FoodieLocation _$FoodieLocationFromJson(Map<String, dynamic> json) {
  return _FoodieLocation.fromJson(json);
}

/// @nodoc
mixin _$FoodieLocation {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodieLocationCopyWith<FoodieLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodieLocationCopyWith<$Res> {
  factory $FoodieLocationCopyWith(
          FoodieLocation value, $Res Function(FoodieLocation) then) =
      _$FoodieLocationCopyWithImpl<$Res>;
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$FoodieLocationCopyWithImpl<$Res>
    implements $FoodieLocationCopyWith<$Res> {
  _$FoodieLocationCopyWithImpl(this._value, this._then);

  final FoodieLocation _value;
  // ignore: unused_field
  final $Res Function(FoodieLocation) _then;

  @override
  $Res call({
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$_FoodieLocationCopyWith<$Res>
    implements $FoodieLocationCopyWith<$Res> {
  factory _$$_FoodieLocationCopyWith(
          _$_FoodieLocation value, $Res Function(_$_FoodieLocation) then) =
      __$$_FoodieLocationCopyWithImpl<$Res>;
  @override
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$_FoodieLocationCopyWithImpl<$Res>
    extends _$FoodieLocationCopyWithImpl<$Res>
    implements _$$_FoodieLocationCopyWith<$Res> {
  __$$_FoodieLocationCopyWithImpl(
      _$_FoodieLocation _value, $Res Function(_$_FoodieLocation) _then)
      : super(_value, (v) => _then(v as _$_FoodieLocation));

  @override
  _$_FoodieLocation get _value => super._value as _$_FoodieLocation;

  @override
  $Res call({
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$_FoodieLocation(
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
class _$_FoodieLocation extends _FoodieLocation {
  _$_FoodieLocation({required this.latitude, required this.longitude})
      : super._();

  factory _$_FoodieLocation.fromJson(Map<String, dynamic> json) =>
      _$$_FoodieLocationFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'FoodieLocation(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FoodieLocation &&
            const DeepCollectionEquality().equals(other.latitude, latitude) &&
            const DeepCollectionEquality().equals(other.longitude, longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(latitude),
      const DeepCollectionEquality().hash(longitude));

  @JsonKey(ignore: true)
  @override
  _$$_FoodieLocationCopyWith<_$_FoodieLocation> get copyWith =>
      __$$_FoodieLocationCopyWithImpl<_$_FoodieLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FoodieLocationToJson(this);
  }
}

abstract class _FoodieLocation extends FoodieLocation {
  factory _FoodieLocation(
      {required final double latitude,
      required final double longitude}) = _$_FoodieLocation;
  _FoodieLocation._() : super._();

  factory _FoodieLocation.fromJson(Map<String, dynamic> json) =
      _$_FoodieLocation.fromJson;

  @override
  double get latitude => throw _privateConstructorUsedError;
  @override
  double get longitude => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_FoodieLocationCopyWith<_$_FoodieLocation> get copyWith =>
      throw _privateConstructorUsedError;
}
