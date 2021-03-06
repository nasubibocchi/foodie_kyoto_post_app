// Mocks generated by Mockito 5.2.0 from annotations
// in foodie_kyoto_post_app/test/google_map_unit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i2;
import 'dart:typed_data' as _i8;

import 'package:foodie_kyoto_post_app/data/model/result.dart' as _i3;
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart' as _i6;
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart'
    as _i5;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i7;
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart'
    as _i4;
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

class _FakeStreamController_0<T> extends _i1.Fake
    implements _i2.StreamController<T> {}

class _FakeResult_1<T> extends _i1.Fake implements _i3.Result<T> {}

class _FakeLatLngBounds_2 extends _i1.Fake implements _i4.LatLngBounds {}

class _FakeScreenCoordinate_3 extends _i1.Fake implements _i4.ScreenCoordinate {
}

class _FakeLatLng_4 extends _i1.Fake implements _i4.LatLng {}

/// A class which mocks [ShopUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockShopUseCase extends _i1.Mock implements _i5.ShopUseCase {
  MockShopUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.StreamController<_i2.Stream<List<_i6.Shop>>>
      get shopUseCaseStreamController =>
          (super.noSuchMethod(Invocation.getter(#shopUseCaseStreamController),
                  returnValue:
                      _FakeStreamController_0<_i2.Stream<List<_i6.Shop>>>())
              as _i2.StreamController<_i2.Stream<List<_i6.Shop>>>);
  @override
  _i2.Future<_i3.Result<List<_i6.Shop>>> fetchShops(
          {int? limit, String? cursor}) =>
      (super.noSuchMethod(
          Invocation.method(#fetchShops, [], {#limit: limit, #cursor: cursor}),
          returnValue: Future<_i3.Result<List<_i6.Shop>>>.value(
              _FakeResult_1<List<_i6.Shop>>())) as _i2
          .Future<_i3.Result<List<_i6.Shop>>>);
  @override
  _i2.Future<_i3.Result<void>> postShop({_i6.Shop? shop}) =>
      (super.noSuchMethod(Invocation.method(#postShop, [], {#shop: shop}),
              returnValue:
                  Future<_i3.Result<void>>.value(_FakeResult_1<void>()))
          as _i2.Future<_i3.Result<void>>);
  @override
  _i2.Future<_i3.Result<_i6.Shop?>> fetchShopByShopId({String? shopId}) =>
      (super.noSuchMethod(
              Invocation.method(#fetchShopByShopId, [], {#shopId: shopId}),
              returnValue: Future<_i3.Result<_i6.Shop?>>.value(
                  _FakeResult_1<_i6.Shop?>()))
          as _i2.Future<_i3.Result<_i6.Shop?>>);
  @override
  _i2.Future<_i3.Result<String>> fetchShopInMapStream(
          {double? latitude, double? longitude, dynamic radius}) =>
      (super.noSuchMethod(
              Invocation.method(#fetchShopInMapStream, [], {
                #latitude: latitude,
                #longitude: longitude,
                #radius: radius
              }),
              returnValue:
                  Future<_i3.Result<String>>.value(_FakeResult_1<String>()))
          as _i2.Future<_i3.Result<String>>);
}

/// A class which mocks [GoogleMapController].
///
/// See the documentation for Mockito's code generation for more information.
class MockGoogleMapController extends _i1.Mock
    implements _i7.GoogleMapController {
  MockGoogleMapController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get mapId =>
      (super.noSuchMethod(Invocation.getter(#mapId), returnValue: 0) as int);
  @override
  _i2.Future<void> clearTileCache(_i4.TileOverlayId? tileOverlayId) =>
      (super.noSuchMethod(Invocation.method(#clearTileCache, [tileOverlayId]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i2.Future<void>);
  @override
  _i2.Future<void> animateCamera(_i4.CameraUpdate? cameraUpdate) =>
      (super.noSuchMethod(Invocation.method(#animateCamera, [cameraUpdate]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i2.Future<void>);
  @override
  _i2.Future<void> moveCamera(_i4.CameraUpdate? cameraUpdate) =>
      (super.noSuchMethod(Invocation.method(#moveCamera, [cameraUpdate]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i2.Future<void>);
  @override
  _i2.Future<void> setMapStyle(String? mapStyle) =>
      (super.noSuchMethod(Invocation.method(#setMapStyle, [mapStyle]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i2.Future<void>);
  @override
  _i2.Future<_i4.LatLngBounds> getVisibleRegion() => (super.noSuchMethod(
          Invocation.method(#getVisibleRegion, []),
          returnValue: Future<_i4.LatLngBounds>.value(_FakeLatLngBounds_2()))
      as _i2.Future<_i4.LatLngBounds>);
  @override
  _i2.Future<_i4.ScreenCoordinate> getScreenCoordinate(_i4.LatLng? latLng) =>
      (super.noSuchMethod(Invocation.method(#getScreenCoordinate, [latLng]),
              returnValue:
                  Future<_i4.ScreenCoordinate>.value(_FakeScreenCoordinate_3()))
          as _i2.Future<_i4.ScreenCoordinate>);
  @override
  _i2.Future<_i4.LatLng> getLatLng(_i4.ScreenCoordinate? screenCoordinate) =>
      (super.noSuchMethod(Invocation.method(#getLatLng, [screenCoordinate]),
              returnValue: Future<_i4.LatLng>.value(_FakeLatLng_4()))
          as _i2.Future<_i4.LatLng>);
  @override
  _i2.Future<void> showMarkerInfoWindow(_i4.MarkerId? markerId) =>
      (super.noSuchMethod(Invocation.method(#showMarkerInfoWindow, [markerId]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i2.Future<void>);
  @override
  _i2.Future<void> hideMarkerInfoWindow(_i4.MarkerId? markerId) =>
      (super.noSuchMethod(Invocation.method(#hideMarkerInfoWindow, [markerId]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i2.Future<void>);
  @override
  _i2.Future<bool> isMarkerInfoWindowShown(_i4.MarkerId? markerId) => (super
      .noSuchMethod(Invocation.method(#isMarkerInfoWindowShown, [markerId]),
          returnValue: Future<bool>.value(false)) as _i2.Future<bool>);
  @override
  _i2.Future<double> getZoomLevel() =>
      (super.noSuchMethod(Invocation.method(#getZoomLevel, []),
          returnValue: Future<double>.value(0.0)) as _i2.Future<double>);
  @override
  _i2.Future<_i8.Uint8List?> takeSnapshot() =>
      (super.noSuchMethod(Invocation.method(#takeSnapshot, []),
              returnValue: Future<_i8.Uint8List?>.value())
          as _i2.Future<_i8.Uint8List?>);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
}
