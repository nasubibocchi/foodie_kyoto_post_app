// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'google_map_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GoogleMapState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            GoogleMapController googleMapController,
            List<Shop> shopList,
            bool isShowingShopInformation,
            PageController infoPageController)
        $default, {
    required TResult Function() creating,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(
            GoogleMapController googleMapController,
            List<Shop> shopList,
            bool isShowingShopInformation,
            PageController infoPageController)?
        $default, {
    TResult Function()? creating,
    TResult Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            GoogleMapController googleMapController,
            List<Shop> shopList,
            bool isShowingShopInformation,
            PageController infoPageController)?
        $default, {
    TResult Function()? creating,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GoogleMapState value) $default, {
    required TResult Function(_GoogleMapStateCreating value) creating,
    required TResult Function(_GoogleMapStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_GoogleMapState value)? $default, {
    TResult Function(_GoogleMapStateCreating value)? creating,
    TResult Function(_GoogleMapStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GoogleMapState value)? $default, {
    TResult Function(_GoogleMapStateCreating value)? creating,
    TResult Function(_GoogleMapStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoogleMapStateCopyWith<$Res> {
  factory $GoogleMapStateCopyWith(
          GoogleMapState value, $Res Function(GoogleMapState) then) =
      _$GoogleMapStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$GoogleMapStateCopyWithImpl<$Res>
    implements $GoogleMapStateCopyWith<$Res> {
  _$GoogleMapStateCopyWithImpl(this._value, this._then);

  final GoogleMapState _value;
  // ignore: unused_field
  final $Res Function(GoogleMapState) _then;
}

/// @nodoc
abstract class _$$_GoogleMapStateCopyWith<$Res> {
  factory _$$_GoogleMapStateCopyWith(
          _$_GoogleMapState value, $Res Function(_$_GoogleMapState) then) =
      __$$_GoogleMapStateCopyWithImpl<$Res>;
  $Res call(
      {GoogleMapController googleMapController,
      List<Shop> shopList,
      bool isShowingShopInformation,
      PageController infoPageController});
}

/// @nodoc
class __$$_GoogleMapStateCopyWithImpl<$Res>
    extends _$GoogleMapStateCopyWithImpl<$Res>
    implements _$$_GoogleMapStateCopyWith<$Res> {
  __$$_GoogleMapStateCopyWithImpl(
      _$_GoogleMapState _value, $Res Function(_$_GoogleMapState) _then)
      : super(_value, (v) => _then(v as _$_GoogleMapState));

  @override
  _$_GoogleMapState get _value => super._value as _$_GoogleMapState;

  @override
  $Res call({
    Object? googleMapController = freezed,
    Object? shopList = freezed,
    Object? isShowingShopInformation = freezed,
    Object? infoPageController = freezed,
  }) {
    return _then(_$_GoogleMapState(
      googleMapController: googleMapController == freezed
          ? _value.googleMapController
          : googleMapController // ignore: cast_nullable_to_non_nullable
              as GoogleMapController,
      shopList: shopList == freezed
          ? _value._shopList
          : shopList // ignore: cast_nullable_to_non_nullable
              as List<Shop>,
      isShowingShopInformation: isShowingShopInformation == freezed
          ? _value.isShowingShopInformation
          : isShowingShopInformation // ignore: cast_nullable_to_non_nullable
              as bool,
      infoPageController: infoPageController == freezed
          ? _value.infoPageController
          : infoPageController // ignore: cast_nullable_to_non_nullable
              as PageController,
    ));
  }
}

/// @nodoc

class _$_GoogleMapState implements _GoogleMapState {
  _$_GoogleMapState(
      {required this.googleMapController,
      final List<Shop> shopList = const [],
      this.isShowingShopInformation = false,
      required this.infoPageController})
      : _shopList = shopList;

  @override
  final GoogleMapController googleMapController;
  final List<Shop> _shopList;
  @override
  @JsonKey()
  List<Shop> get shopList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shopList);
  }

  @override
  @JsonKey()
  final bool isShowingShopInformation;
  @override
  final PageController infoPageController;

  @override
  String toString() {
    return 'GoogleMapState(googleMapController: $googleMapController, shopList: $shopList, isShowingShopInformation: $isShowingShopInformation, infoPageController: $infoPageController)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GoogleMapState &&
            const DeepCollectionEquality()
                .equals(other.googleMapController, googleMapController) &&
            const DeepCollectionEquality().equals(other._shopList, _shopList) &&
            const DeepCollectionEquality().equals(
                other.isShowingShopInformation, isShowingShopInformation) &&
            const DeepCollectionEquality()
                .equals(other.infoPageController, infoPageController));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(googleMapController),
      const DeepCollectionEquality().hash(_shopList),
      const DeepCollectionEquality().hash(isShowingShopInformation),
      const DeepCollectionEquality().hash(infoPageController));

  @JsonKey(ignore: true)
  @override
  _$$_GoogleMapStateCopyWith<_$_GoogleMapState> get copyWith =>
      __$$_GoogleMapStateCopyWithImpl<_$_GoogleMapState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            GoogleMapController googleMapController,
            List<Shop> shopList,
            bool isShowingShopInformation,
            PageController infoPageController)
        $default, {
    required TResult Function() creating,
    required TResult Function() error,
  }) {
    return $default(googleMapController, shopList, isShowingShopInformation,
        infoPageController);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(
            GoogleMapController googleMapController,
            List<Shop> shopList,
            bool isShowingShopInformation,
            PageController infoPageController)?
        $default, {
    TResult Function()? creating,
    TResult Function()? error,
  }) {
    return $default?.call(googleMapController, shopList,
        isShowingShopInformation, infoPageController);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            GoogleMapController googleMapController,
            List<Shop> shopList,
            bool isShowingShopInformation,
            PageController infoPageController)?
        $default, {
    TResult Function()? creating,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(googleMapController, shopList, isShowingShopInformation,
          infoPageController);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GoogleMapState value) $default, {
    required TResult Function(_GoogleMapStateCreating value) creating,
    required TResult Function(_GoogleMapStateError value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_GoogleMapState value)? $default, {
    TResult Function(_GoogleMapStateCreating value)? creating,
    TResult Function(_GoogleMapStateError value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GoogleMapState value)? $default, {
    TResult Function(_GoogleMapStateCreating value)? creating,
    TResult Function(_GoogleMapStateError value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _GoogleMapState implements GoogleMapState {
  factory _GoogleMapState(
      {required final GoogleMapController googleMapController,
      final List<Shop> shopList,
      final bool isShowingShopInformation,
      required final PageController infoPageController}) = _$_GoogleMapState;

  GoogleMapController get googleMapController =>
      throw _privateConstructorUsedError;
  List<Shop> get shopList => throw _privateConstructorUsedError;
  bool get isShowingShopInformation => throw _privateConstructorUsedError;
  PageController get infoPageController => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_GoogleMapStateCopyWith<_$_GoogleMapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_GoogleMapStateCreatingCopyWith<$Res> {
  factory _$$_GoogleMapStateCreatingCopyWith(_$_GoogleMapStateCreating value,
          $Res Function(_$_GoogleMapStateCreating) then) =
      __$$_GoogleMapStateCreatingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_GoogleMapStateCreatingCopyWithImpl<$Res>
    extends _$GoogleMapStateCopyWithImpl<$Res>
    implements _$$_GoogleMapStateCreatingCopyWith<$Res> {
  __$$_GoogleMapStateCreatingCopyWithImpl(_$_GoogleMapStateCreating _value,
      $Res Function(_$_GoogleMapStateCreating) _then)
      : super(_value, (v) => _then(v as _$_GoogleMapStateCreating));

  @override
  _$_GoogleMapStateCreating get _value =>
      super._value as _$_GoogleMapStateCreating;
}

/// @nodoc

class _$_GoogleMapStateCreating implements _GoogleMapStateCreating {
  _$_GoogleMapStateCreating();

  @override
  String toString() {
    return 'GoogleMapState.creating()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GoogleMapStateCreating);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            GoogleMapController googleMapController,
            List<Shop> shopList,
            bool isShowingShopInformation,
            PageController infoPageController)
        $default, {
    required TResult Function() creating,
    required TResult Function() error,
  }) {
    return creating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(
            GoogleMapController googleMapController,
            List<Shop> shopList,
            bool isShowingShopInformation,
            PageController infoPageController)?
        $default, {
    TResult Function()? creating,
    TResult Function()? error,
  }) {
    return creating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            GoogleMapController googleMapController,
            List<Shop> shopList,
            bool isShowingShopInformation,
            PageController infoPageController)?
        $default, {
    TResult Function()? creating,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (creating != null) {
      return creating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GoogleMapState value) $default, {
    required TResult Function(_GoogleMapStateCreating value) creating,
    required TResult Function(_GoogleMapStateError value) error,
  }) {
    return creating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_GoogleMapState value)? $default, {
    TResult Function(_GoogleMapStateCreating value)? creating,
    TResult Function(_GoogleMapStateError value)? error,
  }) {
    return creating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GoogleMapState value)? $default, {
    TResult Function(_GoogleMapStateCreating value)? creating,
    TResult Function(_GoogleMapStateError value)? error,
    required TResult orElse(),
  }) {
    if (creating != null) {
      return creating(this);
    }
    return orElse();
  }
}

abstract class _GoogleMapStateCreating implements GoogleMapState {
  factory _GoogleMapStateCreating() = _$_GoogleMapStateCreating;
}

/// @nodoc
abstract class _$$_GoogleMapStateErrorCopyWith<$Res> {
  factory _$$_GoogleMapStateErrorCopyWith(_$_GoogleMapStateError value,
          $Res Function(_$_GoogleMapStateError) then) =
      __$$_GoogleMapStateErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_GoogleMapStateErrorCopyWithImpl<$Res>
    extends _$GoogleMapStateCopyWithImpl<$Res>
    implements _$$_GoogleMapStateErrorCopyWith<$Res> {
  __$$_GoogleMapStateErrorCopyWithImpl(_$_GoogleMapStateError _value,
      $Res Function(_$_GoogleMapStateError) _then)
      : super(_value, (v) => _then(v as _$_GoogleMapStateError));

  @override
  _$_GoogleMapStateError get _value => super._value as _$_GoogleMapStateError;
}

/// @nodoc

class _$_GoogleMapStateError implements _GoogleMapStateError {
  _$_GoogleMapStateError();

  @override
  String toString() {
    return 'GoogleMapState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_GoogleMapStateError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            GoogleMapController googleMapController,
            List<Shop> shopList,
            bool isShowingShopInformation,
            PageController infoPageController)
        $default, {
    required TResult Function() creating,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(
            GoogleMapController googleMapController,
            List<Shop> shopList,
            bool isShowingShopInformation,
            PageController infoPageController)?
        $default, {
    TResult Function()? creating,
    TResult Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            GoogleMapController googleMapController,
            List<Shop> shopList,
            bool isShowingShopInformation,
            PageController infoPageController)?
        $default, {
    TResult Function()? creating,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GoogleMapState value) $default, {
    required TResult Function(_GoogleMapStateCreating value) creating,
    required TResult Function(_GoogleMapStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_GoogleMapState value)? $default, {
    TResult Function(_GoogleMapStateCreating value)? creating,
    TResult Function(_GoogleMapStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GoogleMapState value)? $default, {
    TResult Function(_GoogleMapStateCreating value)? creating,
    TResult Function(_GoogleMapStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _GoogleMapStateError implements GoogleMapState {
  factory _GoogleMapStateError() = _$_GoogleMapStateError;
}
