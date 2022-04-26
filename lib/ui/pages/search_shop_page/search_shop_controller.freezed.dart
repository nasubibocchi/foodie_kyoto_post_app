// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_shop_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchShopState {
  String? get searchText => throw _privateConstructorUsedError;
  List<FoodiePrediction>? get searchResultList =>
      throw _privateConstructorUsedError;
  TextEditingController get searchController =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchShopStateCopyWith<SearchShopState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchShopStateCopyWith<$Res> {
  factory $SearchShopStateCopyWith(
          SearchShopState value, $Res Function(SearchShopState) then) =
      _$SearchShopStateCopyWithImpl<$Res>;
  $Res call(
      {String? searchText,
      List<FoodiePrediction>? searchResultList,
      TextEditingController searchController});
}

/// @nodoc
class _$SearchShopStateCopyWithImpl<$Res>
    implements $SearchShopStateCopyWith<$Res> {
  _$SearchShopStateCopyWithImpl(this._value, this._then);

  final SearchShopState _value;
  // ignore: unused_field
  final $Res Function(SearchShopState) _then;

  @override
  $Res call({
    Object? searchText = freezed,
    Object? searchResultList = freezed,
    Object? searchController = freezed,
  }) {
    return _then(_value.copyWith(
      searchText: searchText == freezed
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String?,
      searchResultList: searchResultList == freezed
          ? _value.searchResultList
          : searchResultList // ignore: cast_nullable_to_non_nullable
              as List<FoodiePrediction>?,
      searchController: searchController == freezed
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ));
  }
}

/// @nodoc
abstract class _$SearchShopStateCopyWith<$Res>
    implements $SearchShopStateCopyWith<$Res> {
  factory _$SearchShopStateCopyWith(
          _SearchShopState value, $Res Function(_SearchShopState) then) =
      __$SearchShopStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? searchText,
      List<FoodiePrediction>? searchResultList,
      TextEditingController searchController});
}

/// @nodoc
class __$SearchShopStateCopyWithImpl<$Res>
    extends _$SearchShopStateCopyWithImpl<$Res>
    implements _$SearchShopStateCopyWith<$Res> {
  __$SearchShopStateCopyWithImpl(
      _SearchShopState _value, $Res Function(_SearchShopState) _then)
      : super(_value, (v) => _then(v as _SearchShopState));

  @override
  _SearchShopState get _value => super._value as _SearchShopState;

  @override
  $Res call({
    Object? searchText = freezed,
    Object? searchResultList = freezed,
    Object? searchController = freezed,
  }) {
    return _then(_SearchShopState(
      searchText: searchText == freezed
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String?,
      searchResultList: searchResultList == freezed
          ? _value.searchResultList
          : searchResultList // ignore: cast_nullable_to_non_nullable
              as List<FoodiePrediction>?,
      searchController: searchController == freezed
          ? _value.searchController
          : searchController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ));
  }
}

/// @nodoc

class _$_SearchShopState implements _SearchShopState {
  _$_SearchShopState(
      {required this.searchText,
      final List<FoodiePrediction>? searchResultList,
      required this.searchController})
      : _searchResultList = searchResultList;

  @override
  final String? searchText;
  final List<FoodiePrediction>? _searchResultList;
  @override
  List<FoodiePrediction>? get searchResultList {
    final value = _searchResultList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final TextEditingController searchController;

  @override
  String toString() {
    return 'SearchShopState(searchText: $searchText, searchResultList: $searchResultList, searchController: $searchController)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchShopState &&
            const DeepCollectionEquality()
                .equals(other.searchText, searchText) &&
            const DeepCollectionEquality()
                .equals(other.searchResultList, searchResultList) &&
            const DeepCollectionEquality()
                .equals(other.searchController, searchController));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(searchText),
      const DeepCollectionEquality().hash(searchResultList),
      const DeepCollectionEquality().hash(searchController));

  @JsonKey(ignore: true)
  @override
  _$SearchShopStateCopyWith<_SearchShopState> get copyWith =>
      __$SearchShopStateCopyWithImpl<_SearchShopState>(this, _$identity);
}

abstract class _SearchShopState implements SearchShopState {
  factory _SearchShopState(
          {required final String? searchText,
          final List<FoodiePrediction>? searchResultList,
          required final TextEditingController searchController}) =
      _$_SearchShopState;

  @override
  String? get searchText => throw _privateConstructorUsedError;
  @override
  List<FoodiePrediction>? get searchResultList =>
      throw _privateConstructorUsedError;
  @override
  TextEditingController get searchController =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SearchShopStateCopyWith<_SearchShopState> get copyWith =>
      throw _privateConstructorUsedError;
}
