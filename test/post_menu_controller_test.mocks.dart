// Mocks generated by Mockito 5.2.0 from annotations
// in foodie_kyoto_post_app/test/post_menu_controller_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:foodie_kyoto_post_app/data/model/result.dart' as _i2;
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart' as _i5;
import 'package:foodie_kyoto_post_app/domain/use_case/menu_use_case.dart'
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

/// A class which mocks [MenuUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockMenuUseCase extends _i1.Mock implements _i3.MenuUseCase {
  MockMenuUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i5.Menu>> createMenu({_i5.Menu? menu}) =>
      (super.noSuchMethod(Invocation.method(#createMenu, [], {#menu: menu}),
              returnValue:
                  Future<_i2.Result<_i5.Menu>>.value(_FakeResult_0<_i5.Menu>()))
          as _i4.Future<_i2.Result<_i5.Menu>>);
}