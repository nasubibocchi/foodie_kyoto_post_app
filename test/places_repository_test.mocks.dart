// Mocks generated by Mockito 5.1.0 from annotations
// in foodie_kyoto_post_app/test/places_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:foodie_kyoto_post_app/data/model/foodie_location_model.dart'
    as _i7;
import 'package:foodie_kyoto_post_app/data/model/foodie_prediction_model.dart'
    as _i6;
import 'package:foodie_kyoto_post_app/data/model/result.dart' as _i3;
import 'package:foodie_kyoto_post_app/data/remote/data_source/places_data_source.dart'
    as _i4;
import 'package:google_maps_webservice/places.dart' as _i2;
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

class _FakeGoogleMapsPlaces_0 extends _i1.Fake implements _i2.GoogleMapsPlaces {
}

class _FakeResult_1<T> extends _i1.Fake implements _i3.Result<T> {}

/// A class which mocks [PlacesDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockPlacesDataSource extends _i1.Mock implements _i4.PlacesDataSource {
  MockPlacesDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GoogleMapsPlaces get places =>
      (super.noSuchMethod(Invocation.getter(#places),
          returnValue: _FakeGoogleMapsPlaces_0()) as _i2.GoogleMapsPlaces);
  @override
  set places(_i2.GoogleMapsPlaces? _places) =>
      super.noSuchMethod(Invocation.setter(#places, _places),
          returnValueForMissingStub: null);
  @override
  void initGooglePlaces({String? apiKey}) => super.noSuchMethod(
      Invocation.method(#initGooglePlaces, [], {#apiKey: apiKey}),
      returnValueForMissingStub: null);
  @override
  _i5.Future<_i3.Result<List<_i6.FoodiePredictionModel>>>
      searchShopsByAutoComplete({String? body}) => (super.noSuchMethod(
              Invocation.method(#searchShopsByAutoComplete, [], {#body: body}),
              returnValue:
                  Future<_i3.Result<List<_i6.FoodiePredictionModel>>>.value(
                      _FakeResult_1<List<_i6.FoodiePredictionModel>>()))
          as _i5.Future<_i3.Result<List<_i6.FoodiePredictionModel>>>);
  @override
  _i5.Future<_i3.Result<_i7.FoodieLocationModel?>> searchShopDetailByPlaceId(
          {String? placeId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #searchShopDetailByPlaceId, [], {#placeId: placeId}),
              returnValue: Future<_i3.Result<_i7.FoodieLocationModel?>>.value(
                  _FakeResult_1<_i7.FoodieLocationModel?>()))
          as _i5.Future<_i3.Result<_i7.FoodieLocationModel?>>);
}
