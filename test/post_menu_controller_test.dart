import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/image_file_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_image_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_movie_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/path_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_controller.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_provider.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tuple/tuple.dart';

import 'post_menu_controller_test.mocks.dart';

@GenerateMocks([
  MenuUseCase,
  MenuImageUseCase,
  ImageFileUseCase,
  PathUseCase,
  MenuMovieUseCase
])
void main() {
  final _menuUseCase = MockMenuUseCase();
  final _menuImageUseCase = MockMenuImageUseCase();
  final _imageFileUseCase = MockImageFileUseCase();
  final _pathUseCase = MockPathUseCase();
  final _menuMovieUseCase = MockMenuMovieUseCase();

  final container = ProviderContainer(overrides: [
    postMenuProvider.overrideWithProvider(StateNotifierProvider.family<
            PostMenuController, PostMenuState, Tuple2<String, Menu?>>(
        (ref, tuple) => PostMenuController(
            _menuUseCase,
            _menuImageUseCase,
            _imageFileUseCase,
            _pathUseCase,
            _menuMovieUseCase,
            tuple.item1,
            tuple.item2))),
  ]);

  group('when initial menu is not defined', () {
    const shopId = 'shop_id_1';
    final model =
        container.read(postMenuProvider(const Tuple2(shopId, null)).notifier);
    group('onEditMenuName', () {
      test('when input string', () {
        model.onEditMenuName('name');
        model.debugState.when(
          (name, _, __, ___, ____, _____, ______, _______, ________, _________,
              __________, ___________, ____________) {
            expect(name, 'name');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });

      test('when input symbol', () {
        model.onEditMenuName('🦆');
        model.debugState.when(
          (name, _, __, ___, ____, _____, ______, _______, ________, _________,
                  __________, ___________, ____________) =>
              expect(name, '🦆'),
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });
    });

    group('onEditReview', () {
      test('when input string', () {
        model.onEditReview('レビュー!');
        model.debugState.when(
          (_, __, ___, ____, _____, ______, review, _______, ________,
              _________, __________, ___________, ____________) {
            expect(review, 'レビュー!');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });

      test('when input symbol', () {
        model.onEditReview('🦆');
        model.debugState.when(
          (_, __, ___, ____, _____, ______, review, _______, ________,
              _________, __________, ___________, ____________) {
            expect(review, '🦆');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });
    });

    group('onEditEnglishReview', () {
      test('when input string', () {
        model.onEditEnglishReview('review!');
        model.debugState.when(
          (_, __, ___, ____, _____, ______, _______, ________, enReview,
              _________, __________, ___________, ____________) {
            expect(enReview, 'review!');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });

      test('when input symbol', () {
        model.onEditEnglishReview('🦆');
        model.debugState.when(
          (_, __, ___, ____, _____, ______, _______, ________, enReview,
              _________, __________, ___________, ____________) {
            expect(enReview, '🦆');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });
    });

    group('onEditPrice', () {
      test('when input number string', () {
        model.onEditPrice('122334');
        model.debugState.when(
          (_, __, ___, ____, price, _____, ______, _______, ________, _________,
              __________, ___________, ____________) {
            expect(price, 122334);
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });

      test('when empty', () {
        model.onEditPrice('');
        model.debugState.when(
          (_, __, ___, ____, price, _____, ______, _______, ________, _________,
              __________, ___________, ____________) {
            expect(price, 0);
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });
    });

    group('postMenu', () {
      test('when review comment is empty', () async {
        model.onEditReview('');

        when(_menuImageUseCase.deleteImages(shopId: shopId, menuName: 'name'))
            .thenAnswer((_) async {
          return Success('path');
        });

        when(_menuMovieUseCase.deleteMovies(shopId: shopId, menuName: 'name'))
            .thenAnswer((_) async {
          return Success('path');
        });

        model.onEditMenuName('name');
        model.onEditPrice('300');

        final result = await model.createOrModifyMenu();

        expect(result, PostResults.empty);
      });
    });
  });
}
