// Mocks generated by Mockito 5.2.0 from annotations
// in foodie_kyoto_post_app/test/google_map_unit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i2;
import 'dart:typed_data' as _i11;

import 'package:flutter/foundation.dart' as _i6;
import 'package:flutter/gestures.dart' as _i10;
import 'package:flutter/material.dart' as _i5;
import 'package:foodie_kyoto_post_app/data/model/result.dart' as _i3;
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart' as _i8;
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart'
    as _i7;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i9;
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

class _FakeCameraPosition_2 extends _i1.Fake implements _i4.CameraPosition {}

class _FakeCameraTargetBounds_3 extends _i1.Fake
    implements _i4.CameraTargetBounds {}

class _FakeMinMaxZoomPreference_4 extends _i1.Fake
    implements _i4.MinMaxZoomPreference {}

class _FakeEdgeInsets_5 extends _i1.Fake implements _i5.EdgeInsets {}

class _FakeState_6<T extends _i5.StatefulWidget> extends _i1.Fake
    implements _i5.State<T> {
  @override
  String toString({_i6.DiagnosticLevel? minLevel = _i6.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeStatefulElement_7 extends _i1.Fake implements _i5.StatefulElement {
  @override
  String toString({_i6.DiagnosticLevel? minLevel = _i6.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeDiagnosticsNode_8 extends _i1.Fake implements _i6.DiagnosticsNode {
  @override
  String toString(
          {_i6.TextTreeConfiguration? parentConfiguration,
          _i6.DiagnosticLevel? minLevel = _i6.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeLatLngBounds_9 extends _i1.Fake implements _i4.LatLngBounds {}

class _FakeScreenCoordinate_10 extends _i1.Fake
    implements _i4.ScreenCoordinate {}

class _FakeLatLng_11 extends _i1.Fake implements _i4.LatLng {}

/// A class which mocks [ShopUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockShopUseCase extends _i1.Mock implements _i7.ShopUseCase {
  MockShopUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.StreamController<_i2.Stream<List<_i8.Shop>>>
      get shopUseCaseStreamController =>
          (super.noSuchMethod(Invocation.getter(#shopUseCaseStreamController),
                  returnValue:
                      _FakeStreamController_0<_i2.Stream<List<_i8.Shop>>>())
              as _i2.StreamController<_i2.Stream<List<_i8.Shop>>>);
  @override
  _i2.Future<_i3.Result<List<_i8.Shop>>> fetchShops(
          {int? limit, String? cursor}) =>
      (super.noSuchMethod(
          Invocation.method(#fetchShops, [], {#limit: limit, #cursor: cursor}),
          returnValue: Future<_i3.Result<List<_i8.Shop>>>.value(
              _FakeResult_1<List<_i8.Shop>>())) as _i2
          .Future<_i3.Result<List<_i8.Shop>>>);
  @override
  _i2.Future<_i3.Result<void>> postShop({_i8.Shop? shop}) =>
      (super.noSuchMethod(Invocation.method(#postShop, [], {#shop: shop}),
              returnValue:
                  Future<_i3.Result<void>>.value(_FakeResult_1<void>()))
          as _i2.Future<_i3.Result<void>>);
  @override
  _i2.Future<_i3.Result<_i8.Shop?>> fetchShopByShopId({String? shopId}) =>
      (super.noSuchMethod(
              Invocation.method(#fetchShopByShopId, [], {#shopId: shopId}),
              returnValue: Future<_i3.Result<_i8.Shop?>>.value(
                  _FakeResult_1<_i8.Shop?>()))
          as _i2.Future<_i3.Result<_i8.Shop?>>);
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

/// A class which mocks [GoogleMap].
///
/// See the documentation for Mockito's code generation for more information.
class MockGoogleMap extends _i1.Mock implements _i9.GoogleMap {
  MockGoogleMap() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.CameraPosition get initialCameraPosition =>
      (super.noSuchMethod(Invocation.getter(#initialCameraPosition),
          returnValue: _FakeCameraPosition_2()) as _i4.CameraPosition);
  @override
  bool get compassEnabled => (super
          .noSuchMethod(Invocation.getter(#compassEnabled), returnValue: false)
      as bool);
  @override
  bool get mapToolbarEnabled =>
      (super.noSuchMethod(Invocation.getter(#mapToolbarEnabled),
          returnValue: false) as bool);
  @override
  _i4.CameraTargetBounds get cameraTargetBounds =>
      (super.noSuchMethod(Invocation.getter(#cameraTargetBounds),
          returnValue: _FakeCameraTargetBounds_3()) as _i4.CameraTargetBounds);
  @override
  _i4.MapType get mapType => (super.noSuchMethod(Invocation.getter(#mapType),
      returnValue: _i4.MapType.none) as _i4.MapType);
  @override
  _i4.MinMaxZoomPreference get minMaxZoomPreference => (super.noSuchMethod(
      Invocation.getter(#minMaxZoomPreference),
      returnValue: _FakeMinMaxZoomPreference_4()) as _i4.MinMaxZoomPreference);
  @override
  bool get rotateGesturesEnabled =>
      (super.noSuchMethod(Invocation.getter(#rotateGesturesEnabled),
          returnValue: false) as bool);
  @override
  bool get scrollGesturesEnabled =>
      (super.noSuchMethod(Invocation.getter(#scrollGesturesEnabled),
          returnValue: false) as bool);
  @override
  bool get zoomControlsEnabled =>
      (super.noSuchMethod(Invocation.getter(#zoomControlsEnabled),
          returnValue: false) as bool);
  @override
  bool get zoomGesturesEnabled =>
      (super.noSuchMethod(Invocation.getter(#zoomGesturesEnabled),
          returnValue: false) as bool);
  @override
  bool get liteModeEnabled => (super
          .noSuchMethod(Invocation.getter(#liteModeEnabled), returnValue: false)
      as bool);
  @override
  bool get tiltGesturesEnabled =>
      (super.noSuchMethod(Invocation.getter(#tiltGesturesEnabled),
          returnValue: false) as bool);
  @override
  _i5.EdgeInsets get padding => (super.noSuchMethod(Invocation.getter(#padding),
      returnValue: _FakeEdgeInsets_5()) as _i5.EdgeInsets);
  @override
  Set<_i4.Marker> get markers =>
      (super.noSuchMethod(Invocation.getter(#markers),
          returnValue: <_i4.Marker>{}) as Set<_i4.Marker>);
  @override
  Set<_i4.Polygon> get polygons =>
      (super.noSuchMethod(Invocation.getter(#polygons),
          returnValue: <_i4.Polygon>{}) as Set<_i4.Polygon>);
  @override
  Set<_i4.Polyline> get polylines =>
      (super.noSuchMethod(Invocation.getter(#polylines),
          returnValue: <_i4.Polyline>{}) as Set<_i4.Polyline>);
  @override
  Set<_i4.Circle> get circles =>
      (super.noSuchMethod(Invocation.getter(#circles),
          returnValue: <_i4.Circle>{}) as Set<_i4.Circle>);
  @override
  Set<_i4.TileOverlay> get tileOverlays =>
      (super.noSuchMethod(Invocation.getter(#tileOverlays),
          returnValue: <_i4.TileOverlay>{}) as Set<_i4.TileOverlay>);
  @override
  bool get myLocationEnabled =>
      (super.noSuchMethod(Invocation.getter(#myLocationEnabled),
          returnValue: false) as bool);
  @override
  bool get myLocationButtonEnabled =>
      (super.noSuchMethod(Invocation.getter(#myLocationButtonEnabled),
          returnValue: false) as bool);
  @override
  bool get indoorViewEnabled =>
      (super.noSuchMethod(Invocation.getter(#indoorViewEnabled),
          returnValue: false) as bool);
  @override
  bool get trafficEnabled => (super
          .noSuchMethod(Invocation.getter(#trafficEnabled), returnValue: false)
      as bool);
  @override
  bool get buildingsEnabled =>
      (super.noSuchMethod(Invocation.getter(#buildingsEnabled),
          returnValue: false) as bool);
  @override
  Set<_i6.Factory<_i10.OneSequenceGestureRecognizer>> get gestureRecognizers =>
      (super.noSuchMethod(Invocation.getter(#gestureRecognizers),
              returnValue: <_i6.Factory<_i10.OneSequenceGestureRecognizer>>{})
          as Set<_i6.Factory<_i10.OneSequenceGestureRecognizer>>);
  @override
  _i5.State<_i5.StatefulWidget> createState() =>
      (super.noSuchMethod(Invocation.method(#createState, []),
              returnValue: _FakeState_6<_i5.StatefulWidget>())
          as _i5.State<_i5.StatefulWidget>);
  @override
  _i5.StatefulElement createElement() =>
      (super.noSuchMethod(Invocation.method(#createElement, []),
          returnValue: _FakeStatefulElement_7()) as _i5.StatefulElement);
  @override
  String toStringShort() => (super
          .noSuchMethod(Invocation.method(#toStringShort, []), returnValue: '')
      as String);
  @override
  void debugFillProperties(_i6.DiagnosticPropertiesBuilder? properties) =>
      super.noSuchMethod(Invocation.method(#debugFillProperties, [properties]),
          returnValueForMissingStub: null);
  @override
  String toStringShallow(
          {String? joiner = r', ',
          _i6.DiagnosticLevel? minLevel = _i6.DiagnosticLevel.debug}) =>
      (super.noSuchMethod(
          Invocation.method(
              #toStringShallow, [], {#joiner: joiner, #minLevel: minLevel}),
          returnValue: '') as String);
  @override
  String toStringDeep(
          {String? prefixLineOne = r'',
          String? prefixOtherLines,
          _i6.DiagnosticLevel? minLevel = _i6.DiagnosticLevel.debug}) =>
      (super.noSuchMethod(
          Invocation.method(#toStringDeep, [], {
            #prefixLineOne: prefixLineOne,
            #prefixOtherLines: prefixOtherLines,
            #minLevel: minLevel
          }),
          returnValue: '') as String);
  @override
  _i6.DiagnosticsNode toDiagnosticsNode(
          {String? name, _i6.DiagnosticsTreeStyle? style}) =>
      (super.noSuchMethod(
          Invocation.method(
              #toDiagnosticsNode, [], {#name: name, #style: style}),
          returnValue: _FakeDiagnosticsNode_8()) as _i6.DiagnosticsNode);
  @override
  List<_i6.DiagnosticsNode> debugDescribeChildren() =>
      (super.noSuchMethod(Invocation.method(#debugDescribeChildren, []),
          returnValue: <_i6.DiagnosticsNode>[]) as List<_i6.DiagnosticsNode>);
  @override
  String toString({_i6.DiagnosticLevel? minLevel = _i6.DiagnosticLevel.info}) =>
      super.toString();
}

/// A class which mocks [GoogleMapController].
///
/// See the documentation for Mockito's code generation for more information.
class MockGoogleMapController extends _i1.Mock
    implements _i9.GoogleMapController {
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
          returnValue: Future<_i4.LatLngBounds>.value(_FakeLatLngBounds_9()))
      as _i2.Future<_i4.LatLngBounds>);
  @override
  _i2.Future<_i4.ScreenCoordinate> getScreenCoordinate(_i4.LatLng? latLng) =>
      (super.noSuchMethod(Invocation.method(#getScreenCoordinate, [latLng]),
          returnValue: Future<_i4.ScreenCoordinate>.value(
              _FakeScreenCoordinate_10())) as _i2.Future<_i4.ScreenCoordinate>);
  @override
  _i2.Future<_i4.LatLng> getLatLng(_i4.ScreenCoordinate? screenCoordinate) =>
      (super.noSuchMethod(Invocation.method(#getLatLng, [screenCoordinate]),
              returnValue: Future<_i4.LatLng>.value(_FakeLatLng_11()))
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
  _i2.Future<_i11.Uint8List?> takeSnapshot() =>
      (super.noSuchMethod(Invocation.method(#takeSnapshot, []),
              returnValue: Future<_i11.Uint8List?>.value())
          as _i2.Future<_i11.Uint8List?>);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
}
