// Mocks generated by Mockito 5.2.0 from annotations
// in foodie_kyoto_post_app/test/menu_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:foodie_kyoto_post_app/data/model/menu_model.dart' as _i5;
import 'package:foodie_kyoto_post_app/data/model/result.dart' as _i2;
import 'package:foodie_kyoto_post_app/data/remote/data_source/menu_data_source.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeResult_0<T> extends _i1.Fake implements _i2.Result<T> {}

/// A class which mocks [MenuDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMenuDataSource extends _i1.Mock implements _i3.MenuDataSource {
  MockMenuDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i5.MenuModel>> createMenu(
          {_i5.MenuModel? menuModel}) =>
      (super.noSuchMethod(
              Invocation.method(#createMenu, [], {#menuModel: menuModel}),
              returnValue: Future<_i2.Result<_i5.MenuModel>>.value(
                  _FakeResult_0<_i5.MenuModel>()))
          as _i4.Future<_i2.Result<_i5.MenuModel>>);
  @override
  _i4.Future<_i2.Result<List<_i5.MenuModel>>> fetchShopMenus(
          {String? shopId}) =>
      (super.noSuchMethod(
              Invocation.method(#fetchShopMenus, [], {#shopId: shopId}),
              returnValue: Future<_i2.Result<List<_i5.MenuModel>>>.value(
                  _FakeResult_0<List<_i5.MenuModel>>()))
          as _i4.Future<_i2.Result<List<_i5.MenuModel>>>);
}
