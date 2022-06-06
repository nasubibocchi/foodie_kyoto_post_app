// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'shop_detail_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ShopDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Menu> menu) $default, {
    required TResult Function() loading,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(List<Menu> menu)? $default, {
    TResult Function()? loading,
    TResult Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Menu> menu)? $default, {
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ShopDetailState value) $default, {
    required TResult Function(_ShopDetailStateLoading value) loading,
    required TResult Function(_ShopDetailStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_ShopDetailState value)? $default, {
    TResult Function(_ShopDetailStateLoading value)? loading,
    TResult Function(_ShopDetailStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ShopDetailState value)? $default, {
    TResult Function(_ShopDetailStateLoading value)? loading,
    TResult Function(_ShopDetailStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopDetailStateCopyWith<$Res> {
  factory $ShopDetailStateCopyWith(
          ShopDetailState value, $Res Function(ShopDetailState) then) =
      _$ShopDetailStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ShopDetailStateCopyWithImpl<$Res>
    implements $ShopDetailStateCopyWith<$Res> {
  _$ShopDetailStateCopyWithImpl(this._value, this._then);

  final ShopDetailState _value;
  // ignore: unused_field
  final $Res Function(ShopDetailState) _then;
}

/// @nodoc
abstract class _$$_ShopDetailStateCopyWith<$Res> {
  factory _$$_ShopDetailStateCopyWith(
          _$_ShopDetailState value, $Res Function(_$_ShopDetailState) then) =
      __$$_ShopDetailStateCopyWithImpl<$Res>;
  $Res call({List<Menu> menu});
}

/// @nodoc
class __$$_ShopDetailStateCopyWithImpl<$Res>
    extends _$ShopDetailStateCopyWithImpl<$Res>
    implements _$$_ShopDetailStateCopyWith<$Res> {
  __$$_ShopDetailStateCopyWithImpl(
      _$_ShopDetailState _value, $Res Function(_$_ShopDetailState) _then)
      : super(_value, (v) => _then(v as _$_ShopDetailState));

  @override
  _$_ShopDetailState get _value => super._value as _$_ShopDetailState;

  @override
  $Res call({
    Object? menu = freezed,
  }) {
    return _then(_$_ShopDetailState(
      menu: menu == freezed
          ? _value._menu
          : menu // ignore: cast_nullable_to_non_nullable
              as List<Menu>,
    ));
  }
}

/// @nodoc

class _$_ShopDetailState implements _ShopDetailState {
  _$_ShopDetailState({required final List<Menu> menu}) : _menu = menu;

  final List<Menu> _menu;
  @override
  List<Menu> get menu {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_menu);
  }

  @override
  String toString() {
    return 'ShopDetailState(menu: $menu)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShopDetailState &&
            const DeepCollectionEquality().equals(other._menu, _menu));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_menu));

  @JsonKey(ignore: true)
  @override
  _$$_ShopDetailStateCopyWith<_$_ShopDetailState> get copyWith =>
      __$$_ShopDetailStateCopyWithImpl<_$_ShopDetailState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Menu> menu) $default, {
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return $default(menu);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(List<Menu> menu)? $default, {
    TResult Function()? loading,
    TResult Function()? error,
  }) {
    return $default?.call(menu);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Menu> menu)? $default, {
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(menu);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ShopDetailState value) $default, {
    required TResult Function(_ShopDetailStateLoading value) loading,
    required TResult Function(_ShopDetailStateError value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_ShopDetailState value)? $default, {
    TResult Function(_ShopDetailStateLoading value)? loading,
    TResult Function(_ShopDetailStateError value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ShopDetailState value)? $default, {
    TResult Function(_ShopDetailStateLoading value)? loading,
    TResult Function(_ShopDetailStateError value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _ShopDetailState implements ShopDetailState {
  factory _ShopDetailState({required final List<Menu> menu}) =
      _$_ShopDetailState;

  List<Menu> get menu => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_ShopDetailStateCopyWith<_$_ShopDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ShopDetailStateLoadingCopyWith<$Res> {
  factory _$$_ShopDetailStateLoadingCopyWith(_$_ShopDetailStateLoading value,
          $Res Function(_$_ShopDetailStateLoading) then) =
      __$$_ShopDetailStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ShopDetailStateLoadingCopyWithImpl<$Res>
    extends _$ShopDetailStateCopyWithImpl<$Res>
    implements _$$_ShopDetailStateLoadingCopyWith<$Res> {
  __$$_ShopDetailStateLoadingCopyWithImpl(_$_ShopDetailStateLoading _value,
      $Res Function(_$_ShopDetailStateLoading) _then)
      : super(_value, (v) => _then(v as _$_ShopDetailStateLoading));

  @override
  _$_ShopDetailStateLoading get _value =>
      super._value as _$_ShopDetailStateLoading;
}

/// @nodoc

class _$_ShopDetailStateLoading implements _ShopDetailStateLoading {
  _$_ShopDetailStateLoading();

  @override
  String toString() {
    return 'ShopDetailState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShopDetailStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Menu> menu) $default, {
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(List<Menu> menu)? $default, {
    TResult Function()? loading,
    TResult Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Menu> menu)? $default, {
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ShopDetailState value) $default, {
    required TResult Function(_ShopDetailStateLoading value) loading,
    required TResult Function(_ShopDetailStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_ShopDetailState value)? $default, {
    TResult Function(_ShopDetailStateLoading value)? loading,
    TResult Function(_ShopDetailStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ShopDetailState value)? $default, {
    TResult Function(_ShopDetailStateLoading value)? loading,
    TResult Function(_ShopDetailStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ShopDetailStateLoading implements ShopDetailState {
  factory _ShopDetailStateLoading() = _$_ShopDetailStateLoading;
}

/// @nodoc
abstract class _$$_ShopDetailStateErrorCopyWith<$Res> {
  factory _$$_ShopDetailStateErrorCopyWith(_$_ShopDetailStateError value,
          $Res Function(_$_ShopDetailStateError) then) =
      __$$_ShopDetailStateErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ShopDetailStateErrorCopyWithImpl<$Res>
    extends _$ShopDetailStateCopyWithImpl<$Res>
    implements _$$_ShopDetailStateErrorCopyWith<$Res> {
  __$$_ShopDetailStateErrorCopyWithImpl(_$_ShopDetailStateError _value,
      $Res Function(_$_ShopDetailStateError) _then)
      : super(_value, (v) => _then(v as _$_ShopDetailStateError));

  @override
  _$_ShopDetailStateError get _value => super._value as _$_ShopDetailStateError;
}

/// @nodoc

class _$_ShopDetailStateError implements _ShopDetailStateError {
  _$_ShopDetailStateError();

  @override
  String toString() {
    return 'ShopDetailState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_ShopDetailStateError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Menu> menu) $default, {
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(List<Menu> menu)? $default, {
    TResult Function()? loading,
    TResult Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Menu> menu)? $default, {
    TResult Function()? loading,
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
    TResult Function(_ShopDetailState value) $default, {
    required TResult Function(_ShopDetailStateLoading value) loading,
    required TResult Function(_ShopDetailStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_ShopDetailState value)? $default, {
    TResult Function(_ShopDetailStateLoading value)? loading,
    TResult Function(_ShopDetailStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ShopDetailState value)? $default, {
    TResult Function(_ShopDetailStateLoading value)? loading,
    TResult Function(_ShopDetailStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ShopDetailStateError implements ShopDetailState {
  factory _ShopDetailStateError() = _$_ShopDetailStateError;
}
