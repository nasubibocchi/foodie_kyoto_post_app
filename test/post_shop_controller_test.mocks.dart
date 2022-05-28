// Mocks generated by Mockito 5.2.0 from annotations
// in foodie_kyoto_post_app/test/post_shop_controller_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;
import 'dart:convert' as _i11;
import 'dart:typed_data' as _i12;

import 'package:foodie_kyoto_post_app/data/model/result.dart' as _i2;
import 'package:foodie_kyoto_post_app/domain/entity/foodie_prediction.dart'
    as _i8;
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart' as _i6;
import 'package:foodie_kyoto_post_app/domain/entity/shop_detail.dart' as _i9;
import 'package:foodie_kyoto_post_app/domain/use_case/places_use_case.dart'
    as _i7;
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart'
    as _i4;
import 'package:foodie_kyoto_post_app/domain/use_case/string_use_case.dart'
    as _i10;
import 'package:image_picker/image_picker.dart' as _i13;
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart'
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

class _FakeDateTime_1 extends _i1.Fake implements DateTime {}

class _FakeLostData_2 extends _i1.Fake implements _i3.LostData {}

class _FakeLostDataResponse_3 extends _i1.Fake implements _i3.LostDataResponse {
}

/// A class which mocks [ShopUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockShopUseCase extends _i1.Mock implements _i4.ShopUseCase {
  MockShopUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Result<List<_i6.Shop>>> fetchShops(
          {int? limit, String? cursor}) =>
      (super.noSuchMethod(
          Invocation.method(#fetchShops, [], {#limit: limit, #cursor: cursor}),
          returnValue: Future<_i2.Result<List<_i6.Shop>>>.value(
              _FakeResult_0<List<_i6.Shop>>())) as _i5
          .Future<_i2.Result<List<_i6.Shop>>>);
  @override
  _i5.Future<_i2.Result<void>> postShop({_i6.Shop? shop}) =>
      (super.noSuchMethod(Invocation.method(#postShop, [], {#shop: shop}),
              returnValue:
                  Future<_i2.Result<void>>.value(_FakeResult_0<void>()))
          as _i5.Future<_i2.Result<void>>);
  @override
  _i5.Future<_i2.Result<_i6.Shop?>> fetchShopByShopId({String? shopId}) =>
      (super.noSuchMethod(
              Invocation.method(#fetchShopByShopId, [], {#shopId: shopId}),
              returnValue: Future<_i2.Result<_i6.Shop?>>.value(
                  _FakeResult_0<_i6.Shop?>()))
          as _i5.Future<_i2.Result<_i6.Shop?>>);
}

/// A class which mocks [PlacesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockPlacesUseCase extends _i1.Mock implements _i7.PlacesUseCase {
  MockPlacesUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void initGooglePlaces({String? apiKey}) => super.noSuchMethod(
      Invocation.method(#initGooglePlaces, [], {#apiKey: apiKey}),
      returnValueForMissingStub: null);
  @override
  _i5.Future<_i2.Result<List<_i8.FoodiePrediction>>> searchShopsByAutoComplete(
          {String? body}) =>
      (super.noSuchMethod(
              Invocation.method(#searchShopsByAutoComplete, [], {#body: body}),
              returnValue: Future<_i2.Result<List<_i8.FoodiePrediction>>>.value(
                  _FakeResult_0<List<_i8.FoodiePrediction>>()))
          as _i5.Future<_i2.Result<List<_i8.FoodiePrediction>>>);
  @override
  _i5.Future<_i2.Result<_i9.ShopDetail?>> searchShopDetailsByPlaceId(
          {String? placeId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #searchShopDetailsByPlaceId, [], {#placeId: placeId}),
              returnValue: Future<_i2.Result<_i9.ShopDetail?>>.value(
                  _FakeResult_0<_i9.ShopDetail?>()))
          as _i5.Future<_i2.Result<_i9.ShopDetail?>>);
}

/// A class which mocks [StringUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockStringUseCase extends _i1.Mock implements _i10.StringUseCase {
  MockStringUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Result<String?>> postImages(
          {String? path, String? shopId, String? fileName}) =>
      (super.noSuchMethod(
              Invocation.method(#postImages, [],
                  {#path: path, #shopId: shopId, #fileName: fileName}),
              returnValue:
                  Future<_i2.Result<String?>>.value(_FakeResult_0<String?>()))
          as _i5.Future<_i2.Result<String?>>);
  @override
  _i5.Future<_i2.Result<String?>> getImagesUrl(
          {String? path, String? shopId, String? fileName}) =>
      (super.noSuchMethod(
              Invocation.method(#getImagesUrl, [],
                  {#path: path, #shopId: shopId, #fileName: fileName}),
              returnValue:
                  Future<_i2.Result<String?>>.value(_FakeResult_0<String?>()))
          as _i5.Future<_i2.Result<String?>>);
  @override
  _i5.Future<_i2.Result<String>> deleteImages({String? shopId}) => (super
          .noSuchMethod(Invocation.method(#deleteImages, [], {#shopId: shopId}),
              returnValue:
                  Future<_i2.Result<String>>.value(_FakeResult_0<String>()))
      as _i5.Future<_i2.Result<String>>);
}

/// A class which mocks [XFile].
///
/// See the documentation for Mockito's code generation for more information.
class MockXFile extends _i1.Mock implements _i3.XFile {
  MockXFile() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get path =>
      (super.noSuchMethod(Invocation.getter(#path), returnValue: '') as String);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  _i5.Future<void> saveTo(String? path) =>
      (super.noSuchMethod(Invocation.method(#saveTo, [path]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<int> length() =>
      (super.noSuchMethod(Invocation.method(#length, []),
          returnValue: Future<int>.value(0)) as _i5.Future<int>);
  @override
  _i5.Future<String> readAsString(
          {_i11.Encoding? encoding = const _i11.Utf8Codec()}) =>
      (super.noSuchMethod(
          Invocation.method(#readAsString, [], {#encoding: encoding}),
          returnValue: Future<String>.value('')) as _i5.Future<String>);
  @override
  _i5.Future<_i12.Uint8List> readAsBytes() =>
      (super.noSuchMethod(Invocation.method(#readAsBytes, []),
              returnValue: Future<_i12.Uint8List>.value(_i12.Uint8List(0)))
          as _i5.Future<_i12.Uint8List>);
  @override
  _i5.Stream<_i12.Uint8List> openRead([int? start, int? end]) =>
      (super.noSuchMethod(Invocation.method(#openRead, [start, end]),
              returnValue: Stream<_i12.Uint8List>.empty())
          as _i5.Stream<_i12.Uint8List>);
  @override
  _i5.Future<DateTime> lastModified() =>
      (super.noSuchMethod(Invocation.method(#lastModified, []),
              returnValue: Future<DateTime>.value(_FakeDateTime_1()))
          as _i5.Future<DateTime>);
}

/// A class which mocks [ImagePicker].
///
/// See the documentation for Mockito's code generation for more information.
class MockImagePicker extends _i1.Mock implements _i13.ImagePicker {
  MockImagePicker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.PickedFile?> getImage(
          {_i3.ImageSource? source,
          double? maxWidth,
          double? maxHeight,
          int? imageQuality,
          _i3.CameraDevice? preferredCameraDevice = _i3.CameraDevice.rear}) =>
      (super.noSuchMethod(
              Invocation.method(#getImage, [], {
                #source: source,
                #maxWidth: maxWidth,
                #maxHeight: maxHeight,
                #imageQuality: imageQuality,
                #preferredCameraDevice: preferredCameraDevice
              }),
              returnValue: Future<_i3.PickedFile?>.value())
          as _i5.Future<_i3.PickedFile?>);
  @override
  _i5.Future<List<_i3.PickedFile>?> getMultiImage(
          {double? maxWidth, double? maxHeight, int? imageQuality}) =>
      (super.noSuchMethod(
              Invocation.method(#getMultiImage, [], {
                #maxWidth: maxWidth,
                #maxHeight: maxHeight,
                #imageQuality: imageQuality
              }),
              returnValue: Future<List<_i3.PickedFile>?>.value())
          as _i5.Future<List<_i3.PickedFile>?>);
  @override
  _i5.Future<_i3.PickedFile?> getVideo(
          {_i3.ImageSource? source,
          _i3.CameraDevice? preferredCameraDevice = _i3.CameraDevice.rear,
          Duration? maxDuration}) =>
      (super.noSuchMethod(
              Invocation.method(#getVideo, [], {
                #source: source,
                #preferredCameraDevice: preferredCameraDevice,
                #maxDuration: maxDuration
              }),
              returnValue: Future<_i3.PickedFile?>.value())
          as _i5.Future<_i3.PickedFile?>);
  @override
  _i5.Future<_i3.LostData> getLostData() =>
      (super.noSuchMethod(Invocation.method(#getLostData, []),
              returnValue: Future<_i3.LostData>.value(_FakeLostData_2()))
          as _i5.Future<_i3.LostData>);
  @override
  _i5.Future<_i3.XFile?> pickImage(
          {_i3.ImageSource? source,
          double? maxWidth,
          double? maxHeight,
          int? imageQuality,
          _i3.CameraDevice? preferredCameraDevice = _i3.CameraDevice.rear}) =>
      (super.noSuchMethod(
          Invocation.method(#pickImage, [], {
            #source: source,
            #maxWidth: maxWidth,
            #maxHeight: maxHeight,
            #imageQuality: imageQuality,
            #preferredCameraDevice: preferredCameraDevice
          }),
          returnValue: Future<_i3.XFile?>.value()) as _i5.Future<_i3.XFile?>);
  @override
  _i5.Future<List<_i3.XFile>?> pickMultiImage(
          {double? maxWidth, double? maxHeight, int? imageQuality}) =>
      (super.noSuchMethod(
              Invocation.method(#pickMultiImage, [], {
                #maxWidth: maxWidth,
                #maxHeight: maxHeight,
                #imageQuality: imageQuality
              }),
              returnValue: Future<List<_i3.XFile>?>.value())
          as _i5.Future<List<_i3.XFile>?>);
  @override
  _i5.Future<_i3.XFile?> pickVideo(
          {_i3.ImageSource? source,
          _i3.CameraDevice? preferredCameraDevice = _i3.CameraDevice.rear,
          Duration? maxDuration}) =>
      (super.noSuchMethod(
          Invocation.method(#pickVideo, [], {
            #source: source,
            #preferredCameraDevice: preferredCameraDevice,
            #maxDuration: maxDuration
          }),
          returnValue: Future<_i3.XFile?>.value()) as _i5.Future<_i3.XFile?>);
  @override
  _i5.Future<_i3.LostDataResponse> retrieveLostData() =>
      (super.noSuchMethod(Invocation.method(#retrieveLostData, []),
              returnValue:
                  Future<_i3.LostDataResponse>.value(_FakeLostDataResponse_3()))
          as _i5.Future<_i3.LostDataResponse>);
}
