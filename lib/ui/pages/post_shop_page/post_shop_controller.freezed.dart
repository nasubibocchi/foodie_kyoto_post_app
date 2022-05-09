// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'post_shop_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PostShopState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Shop? shop, TextEditingController commentController)
        $default, {
    required TResult Function() loading,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(Shop? shop, TextEditingController commentController)?
        $default, {
    TResult Function()? loading,
    TResult Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Shop? shop, TextEditingController commentController)?
        $default, {
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PostShopState value) $default, {
    required TResult Function(_PostShopStateLoading value) loading,
    required TResult Function(_PostShopStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_PostShopState value)? $default, {
    TResult Function(_PostShopStateLoading value)? loading,
    TResult Function(_PostShopStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PostShopState value)? $default, {
    TResult Function(_PostShopStateLoading value)? loading,
    TResult Function(_PostShopStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostShopStateCopyWith<$Res> {
  factory $PostShopStateCopyWith(
          PostShopState value, $Res Function(PostShopState) then) =
      _$PostShopStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$PostShopStateCopyWithImpl<$Res>
    implements $PostShopStateCopyWith<$Res> {
  _$PostShopStateCopyWithImpl(this._value, this._then);

  final PostShopState _value;
  // ignore: unused_field
  final $Res Function(PostShopState) _then;
}

/// @nodoc
abstract class _$$_PostShopStateCopyWith<$Res> {
  factory _$$_PostShopStateCopyWith(
          _$_PostShopState value, $Res Function(_$_PostShopState) then) =
      __$$_PostShopStateCopyWithImpl<$Res>;
  $Res call({Shop? shop, TextEditingController commentController});
}

/// @nodoc
class __$$_PostShopStateCopyWithImpl<$Res>
    extends _$PostShopStateCopyWithImpl<$Res>
    implements _$$_PostShopStateCopyWith<$Res> {
  __$$_PostShopStateCopyWithImpl(
      _$_PostShopState _value, $Res Function(_$_PostShopState) _then)
      : super(_value, (v) => _then(v as _$_PostShopState));

  @override
  _$_PostShopState get _value => super._value as _$_PostShopState;

  @override
  $Res call({
    Object? shop = freezed,
    Object? commentController = freezed,
  }) {
    return _then(_$_PostShopState(
      shop: shop == freezed
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as Shop?,
      commentController: commentController == freezed
          ? _value.commentController
          : commentController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ));
  }
}

/// @nodoc

class _$_PostShopState implements _PostShopState {
  _$_PostShopState({required this.shop, required this.commentController});

  @override
  final Shop? shop;
  @override
  final TextEditingController commentController;

  @override
  String toString() {
    return 'PostShopState(shop: $shop, commentController: $commentController)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostShopState &&
            const DeepCollectionEquality().equals(other.shop, shop) &&
            const DeepCollectionEquality()
                .equals(other.commentController, commentController));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(shop),
      const DeepCollectionEquality().hash(commentController));

  @JsonKey(ignore: true)
  @override
  _$$_PostShopStateCopyWith<_$_PostShopState> get copyWith =>
      __$$_PostShopStateCopyWithImpl<_$_PostShopState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Shop? shop, TextEditingController commentController)
        $default, {
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return $default(shop, commentController);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(Shop? shop, TextEditingController commentController)?
        $default, {
    TResult Function()? loading,
    TResult Function()? error,
  }) {
    return $default?.call(shop, commentController);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Shop? shop, TextEditingController commentController)?
        $default, {
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(shop, commentController);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PostShopState value) $default, {
    required TResult Function(_PostShopStateLoading value) loading,
    required TResult Function(_PostShopStateError value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_PostShopState value)? $default, {
    TResult Function(_PostShopStateLoading value)? loading,
    TResult Function(_PostShopStateError value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PostShopState value)? $default, {
    TResult Function(_PostShopStateLoading value)? loading,
    TResult Function(_PostShopStateError value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _PostShopState implements PostShopState {
  factory _PostShopState(
          {required final Shop? shop,
          required final TextEditingController commentController}) =
      _$_PostShopState;

  Shop? get shop => throw _privateConstructorUsedError;
  TextEditingController get commentController =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_PostShopStateCopyWith<_$_PostShopState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_PostShopStateLoadingCopyWith<$Res> {
  factory _$$_PostShopStateLoadingCopyWith(_$_PostShopStateLoading value,
          $Res Function(_$_PostShopStateLoading) then) =
      __$$_PostShopStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_PostShopStateLoadingCopyWithImpl<$Res>
    extends _$PostShopStateCopyWithImpl<$Res>
    implements _$$_PostShopStateLoadingCopyWith<$Res> {
  __$$_PostShopStateLoadingCopyWithImpl(_$_PostShopStateLoading _value,
      $Res Function(_$_PostShopStateLoading) _then)
      : super(_value, (v) => _then(v as _$_PostShopStateLoading));

  @override
  _$_PostShopStateLoading get _value => super._value as _$_PostShopStateLoading;
}

/// @nodoc

class _$_PostShopStateLoading implements _PostShopStateLoading {
  _$_PostShopStateLoading();

  @override
  String toString() {
    return 'PostShopState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_PostShopStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Shop? shop, TextEditingController commentController)
        $default, {
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(Shop? shop, TextEditingController commentController)?
        $default, {
    TResult Function()? loading,
    TResult Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Shop? shop, TextEditingController commentController)?
        $default, {
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
    TResult Function(_PostShopState value) $default, {
    required TResult Function(_PostShopStateLoading value) loading,
    required TResult Function(_PostShopStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_PostShopState value)? $default, {
    TResult Function(_PostShopStateLoading value)? loading,
    TResult Function(_PostShopStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PostShopState value)? $default, {
    TResult Function(_PostShopStateLoading value)? loading,
    TResult Function(_PostShopStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _PostShopStateLoading implements PostShopState {
  factory _PostShopStateLoading() = _$_PostShopStateLoading;
}

/// @nodoc
abstract class _$$_PostShopStateErrorCopyWith<$Res> {
  factory _$$_PostShopStateErrorCopyWith(_$_PostShopStateError value,
          $Res Function(_$_PostShopStateError) then) =
      __$$_PostShopStateErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_PostShopStateErrorCopyWithImpl<$Res>
    extends _$PostShopStateCopyWithImpl<$Res>
    implements _$$_PostShopStateErrorCopyWith<$Res> {
  __$$_PostShopStateErrorCopyWithImpl(
      _$_PostShopStateError _value, $Res Function(_$_PostShopStateError) _then)
      : super(_value, (v) => _then(v as _$_PostShopStateError));

  @override
  _$_PostShopStateError get _value => super._value as _$_PostShopStateError;
}

/// @nodoc

class _$_PostShopStateError implements _PostShopStateError {
  _$_PostShopStateError();

  @override
  String toString() {
    return 'PostShopState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_PostShopStateError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Shop? shop, TextEditingController commentController)
        $default, {
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(Shop? shop, TextEditingController commentController)?
        $default, {
    TResult Function()? loading,
    TResult Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Shop? shop, TextEditingController commentController)?
        $default, {
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
    TResult Function(_PostShopState value) $default, {
    required TResult Function(_PostShopStateLoading value) loading,
    required TResult Function(_PostShopStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_PostShopState value)? $default, {
    TResult Function(_PostShopStateLoading value)? loading,
    TResult Function(_PostShopStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PostShopState value)? $default, {
    TResult Function(_PostShopStateLoading value)? loading,
    TResult Function(_PostShopStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _PostShopStateError implements PostShopState {
  factory _PostShopStateError() = _$_PostShopStateError;
}
