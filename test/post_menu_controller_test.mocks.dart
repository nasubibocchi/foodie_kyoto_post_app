// Mocks generated by Mockito 5.2.0 from annotations
// in foodie_kyoto_post_app/test/post_menu_controller_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;
import 'dart:io' as _i8;

import 'package:foodie_kyoto_post_app/data/model/result.dart' as _i2;
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart' as _i5;
import 'package:foodie_kyoto_post_app/domain/use_case/image_file_use_case.dart'
    as _i7;
import 'package:foodie_kyoto_post_app/domain/use_case/menu_image_use_case.dart'
    as _i6;
import 'package:foodie_kyoto_post_app/domain/use_case/menu_use_case.dart'
    as _i3;
import 'package:foodie_kyoto_post_app/domain/use_case/path_use_case.dart'
    as _i9;
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

/// A class which mocks [MenuUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockMenuUseCase extends _i1.Mock implements _i3.MenuUseCase {
  MockMenuUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i5.Menu>> postMenu({_i5.Menu? menu}) =>
      (super.noSuchMethod(Invocation.method(#createMenu, [], {#menu: menu}),
              returnValue:
                  Future<_i2.Result<_i5.Menu>>.value(_FakeResult_0<_i5.Menu>()))
          as _i4.Future<_i2.Result<_i5.Menu>>);
  @override
  _i4.Future<_i2.Result<List<_i5.Menu>>> fetchShopMenus({String? shopId}) =>
      (super.noSuchMethod(
              Invocation.method(#fetchShopMenus, [], {#shopId: shopId}),
              returnValue: Future<_i2.Result<List<_i5.Menu>>>.value(
                  _FakeResult_0<List<_i5.Menu>>()))
          as _i4.Future<_i2.Result<List<_i5.Menu>>>);
}

/// A class which mocks [MenuImageUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockMenuImageUseCase extends _i1.Mock implements _i6.MenuImageUseCase {
  MockMenuImageUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<String?>> postImages(
          {String? path, String? shopId, String? menuName, String? fileName}) =>
      (super.noSuchMethod(
              Invocation.method(#postImages, [], {
                #path: path,
                #shopId: shopId,
                #menuName: menuName,
                #fileName: fileName
              }),
              returnValue:
                  Future<_i2.Result<String?>>.value(_FakeResult_0<String?>()))
          as _i4.Future<_i2.Result<String?>>);
  @override
  _i4.Future<_i2.Result<String?>> getImagesUrl(
          {String? path, String? shopId, String? menuName, String? fileName}) =>
      (super.noSuchMethod(
              Invocation.method(#getImagesUrl, [], {
                #path: path,
                #shopId: shopId,
                #menuName: menuName,
                #fileName: fileName
              }),
              returnValue:
                  Future<_i2.Result<String?>>.value(_FakeResult_0<String?>()))
          as _i4.Future<_i2.Result<String?>>);
  @override
  _i4.Future<_i2.Result<String>> deleteImages(
          {String? shopId, String? menuName}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #deleteImages, [], {#shopId: shopId, #menuName: menuName}),
              returnValue:
                  Future<_i2.Result<String>>.value(_FakeResult_0<String>()))
          as _i4.Future<_i2.Result<String>>);
}

/// A class which mocks [ImageFileUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockImageFileUseCase extends _i1.Mock implements _i7.ImageFileUseCase {
  MockImageFileUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<List<_i8.File>>> pickMultiImage() =>
      (super.noSuchMethod(Invocation.method(#pickMultiImage, []),
              returnValue: Future<_i2.Result<List<_i8.File>>>.value(
                  _FakeResult_0<List<_i8.File>>()))
          as _i4.Future<_i2.Result<List<_i8.File>>>);
  @override
  _i4.Future<_i2.Result<_i8.File?>> pickImage() => (super.noSuchMethod(
          Invocation.method(#pickImage, []),
          returnValue:
              Future<_i2.Result<_i8.File?>>.value(_FakeResult_0<_i8.File?>()))
      as _i4.Future<_i2.Result<_i8.File?>>);
}

/// A class which mocks [PathUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockPathUseCase extends _i1.Mock implements _i9.PathUseCase {
  MockPathUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i8.Directory>> getTempDirectory() =>
      (super.noSuchMethod(Invocation.method(#getTempDirectory, []),
              returnValue: Future<_i2.Result<_i8.Directory>>.value(
                  _FakeResult_0<_i8.Directory>()))
          as _i4.Future<_i2.Result<_i8.Directory>>);
}
