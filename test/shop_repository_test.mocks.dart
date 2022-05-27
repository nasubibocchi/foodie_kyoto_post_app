// Mocks generated by Mockito 5.2.0 from annotations
// in foodie_kyoto_post_app/test/shop_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:foodie_kyoto_post_app/data/model/result.dart' as _i2;
import 'package:foodie_kyoto_post_app/data/model/shop_model.dart' as _i5;
import 'package:foodie_kyoto_post_app/data/remote/data_source/shop_data_source.dart'
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

/// A class which mocks [ShopDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockShopDataSource extends _i1.Mock implements _i3.ShopDataSource {
  MockShopDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<List<_i5.ShopModel>>> fetchShops(
          {int? limit, String? cursor}) =>
      (super.noSuchMethod(
          Invocation.method(#fetchShops, [], {#limit: limit, #cursor: cursor}),
          returnValue: Future<_i2.Result<List<_i5.ShopModel>>>.value(
              _FakeResult_0<List<_i5.ShopModel>>())) as _i4
          .Future<_i2.Result<List<_i5.ShopModel>>>);
  @override
  _i4.Future<_i2.Result<void>> postShop({_i5.ShopModel? shop}) =>
      (super.noSuchMethod(Invocation.method(#postShop, [], {#shop: shop}),
              returnValue:
                  Future<_i2.Result<void>>.value(_FakeResult_0<void>()))
          as _i4.Future<_i2.Result<void>>);
  @override
  _i4.Future<_i2.Result<_i5.ShopModel?>> fetchShopByShopId({String? shopId}) =>
      (super.noSuchMethod(
              Invocation.method(#fetchShopByShopId, [], {#shopId: shopId}),
              returnValue: Future<_i2.Result<_i5.ShopModel?>>.value(
                  _FakeResult_0<_i5.ShopModel?>()))
          as _i4.Future<_i2.Result<_i5.ShopModel?>>);
}
