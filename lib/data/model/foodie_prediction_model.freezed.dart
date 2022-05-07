// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'foodie_prediction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FoodiePredictionModel _$FoodiePredictionModelFromJson(
    Map<String, dynamic> json) {
  return _FoodiePredictionModel.fromJson(json);
}

/// @nodoc
mixin _$FoodiePredictionModel {
  String get description => throw _privateConstructorUsedError;
  String get placeId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodiePredictionModelCopyWith<FoodiePredictionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodiePredictionModelCopyWith<$Res> {
  factory $FoodiePredictionModelCopyWith(FoodiePredictionModel value,
          $Res Function(FoodiePredictionModel) then) =
      _$FoodiePredictionModelCopyWithImpl<$Res>;
  $Res call({String description, String placeId});
}

/// @nodoc
class _$FoodiePredictionModelCopyWithImpl<$Res>
    implements $FoodiePredictionModelCopyWith<$Res> {
  _$FoodiePredictionModelCopyWithImpl(this._value, this._then);

  final FoodiePredictionModel _value;
  // ignore: unused_field
  final $Res Function(FoodiePredictionModel) _then;

  @override
  $Res call({
    Object? description = freezed,
    Object? placeId = freezed,
  }) {
    return _then(_value.copyWith(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: placeId == freezed
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$FoodiePredictionModelCopyWith<$Res>
    implements $FoodiePredictionModelCopyWith<$Res> {
  factory _$FoodiePredictionModelCopyWith(_FoodiePredictionModel value,
          $Res Function(_FoodiePredictionModel) then) =
      __$FoodiePredictionModelCopyWithImpl<$Res>;
  @override
  $Res call({String description, String placeId});
}

/// @nodoc
class __$FoodiePredictionModelCopyWithImpl<$Res>
    extends _$FoodiePredictionModelCopyWithImpl<$Res>
    implements _$FoodiePredictionModelCopyWith<$Res> {
  __$FoodiePredictionModelCopyWithImpl(_FoodiePredictionModel _value,
      $Res Function(_FoodiePredictionModel) _then)
      : super(_value, (v) => _then(v as _FoodiePredictionModel));

  @override
  _FoodiePredictionModel get _value => super._value as _FoodiePredictionModel;

  @override
  $Res call({
    Object? description = freezed,
    Object? placeId = freezed,
  }) {
    return _then(_FoodiePredictionModel(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: placeId == freezed
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FoodiePredictionModel extends _FoodiePredictionModel {
  _$_FoodiePredictionModel({required this.description, required this.placeId})
      : super._();

  factory _$_FoodiePredictionModel.fromJson(Map<String, dynamic> json) =>
      _$$_FoodiePredictionModelFromJson(json);

  @override
  final String description;
  @override
  final String placeId;

  @override
  String toString() {
    return 'FoodiePredictionModel(description: $description, placeId: $placeId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FoodiePredictionModel &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.placeId, placeId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(placeId));

  @JsonKey(ignore: true)
  @override
  _$FoodiePredictionModelCopyWith<_FoodiePredictionModel> get copyWith =>
      __$FoodiePredictionModelCopyWithImpl<_FoodiePredictionModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FoodiePredictionModelToJson(this);
  }
}

abstract class _FoodiePredictionModel extends FoodiePredictionModel {
  factory _FoodiePredictionModel(
      {required final String description,
      required final String placeId}) = _$_FoodiePredictionModel;
  _FoodiePredictionModel._() : super._();

  factory _FoodiePredictionModel.fromJson(Map<String, dynamic> json) =
      _$_FoodiePredictionModel.fromJson;

  @override
  String get description => throw _privateConstructorUsedError;
  @override
  String get placeId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FoodiePredictionModelCopyWith<_FoodiePredictionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
