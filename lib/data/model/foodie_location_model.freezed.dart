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

FoodieLocationModel _$FoodieLocationModelFromJson(Map<String, dynamic> json) {
  return _FoodieLocationModel.fromJson(json);
}

/// @nodoc
mixin _$FoodieLocationModel {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodieLocationModelCopyWith<FoodieLocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodieLocationModelCopyWith<$Res> {
  factory $FoodieLocationModelCopyWith(
          FoodieLocationModel value, $Res Function(FoodieLocationModel) then) =
      _$FoodieLocationModelCopyWithImpl<$Res>;
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$FoodieLocationModelCopyWithImpl<$Res>
    implements $FoodieLocationModelCopyWith<$Res> {
  _$FoodieLocationModelCopyWithImpl(this._value, this._then);

  final FoodieLocationModel _value;
  // ignore: unused_field
  final $Res Function(FoodieLocationModel) _then;

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
abstract class _$$_FoodieLocationModelCopyWith<$Res>
    implements $FoodieLocationModelCopyWith<$Res> {
  factory _$$_FoodieLocationModelCopyWith(_$_FoodieLocationModel value,
          $Res Function(_$_FoodieLocationModel) then) =
      __$$_FoodieLocationModelCopyWithImpl<$Res>;
  @override
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$_FoodieLocationModelCopyWithImpl<$Res>
    extends _$FoodieLocationModelCopyWithImpl<$Res>
    implements _$$_FoodieLocationModelCopyWith<$Res> {
  __$$_FoodieLocationModelCopyWithImpl(_$_FoodieLocationModel _value,
      $Res Function(_$_FoodieLocationModel) _then)
      : super(_value, (v) => _then(v as _$_FoodieLocationModel));

  @override
  _$_FoodieLocationModel get _value => super._value as _$_FoodieLocationModel;

  @override
  $Res call({
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$_FoodieLocationModel(
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
class _$_FoodieLocationModel extends _FoodieLocationModel {
  _$_FoodieLocationModel({required this.latitude, required this.longitude})
      : super._();

  factory _$_FoodieLocationModel.fromJson(Map<String, dynamic> json) =>
      _$$_FoodieLocationModelFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'FoodieLocationModel(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FoodieLocationModel &&
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
  _$$_FoodieLocationModelCopyWith<_$_FoodieLocationModel> get copyWith =>
      __$$_FoodieLocationModelCopyWithImpl<_$_FoodieLocationModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FoodieLocationModelToJson(this);
  }
}

abstract class _FoodieLocationModel extends FoodieLocationModel {
  factory _FoodieLocationModel(
      {required final double latitude,
      required final double longitude}) = _$_FoodieLocationModel;
  _FoodieLocationModel._() : super._();

  factory _FoodieLocationModel.fromJson(Map<String, dynamic> json) =
      _$_FoodieLocationModel.fromJson;

  @override
  double get latitude => throw _privateConstructorUsedError;
  @override
  double get longitude => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_FoodieLocationModelCopyWith<_$_FoodieLocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}
