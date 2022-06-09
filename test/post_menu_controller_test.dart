import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/constants/post_users_data.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/image_file_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_image_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_movie_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/movie_file_use_case.dart';
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
  MenuMovieUseCase,
  MovieFileUseCase,
])
void main() {
  final _menuUseCase = MockMenuUseCase();
  final _menuImageUseCase = MockMenuImageUseCase();
  final _imageFileUseCase = MockImageFileUseCase();
  final _pathUseCase = MockPathUseCase();
  final _menuMovieUseCase = MockMenuMovieUseCase();
  final _movieFileUseCase = MockMovieFileUseCase();

  // Menuがnull = 新規登録 の時のテストのみ実装済み
  group('when initial menu is not defined', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(overrides: [
        postMenuProvider.overrideWithProvider(StateNotifierProvider.family
            .autoDispose<PostMenuController, PostMenuState,
                    Tuple2<String, Menu?>>(
                (ref, tuple) => PostMenuController(
                    _menuUseCase,
                    _menuImageUseCase,
                    _imageFileUseCase,
                    _pathUseCase,
                    _menuMovieUseCase,
                    _movieFileUseCase,
                    tuple.item1,
                    tuple.item2))),
      ]);
    });

    group('onEditMenuName', () {
      test('when input string', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

        model.onEditMenuName('name');
        model.debugState.when(
          (name, _, __, ___, ____, _____, ______, _______, ________, _________,
              __________, ___________, ____________) {
            expect(name, 'name');
          },
          loading: () {
            // ignore: avoid_print
            print('test is not passed');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });

      test('when input symbol', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

        model.onEditMenuName('🦆');
        model.debugState.when(
          (name, _, __, ___, ____, _____, ______, _______, ________, _________,
                  __________, ___________, ____________) =>
              expect(name, '🦆'),
          loading: () {
            // ignore: avoid_print
            print('test is not passed');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });
    });

    group('onEditReview', () {
      test('when input string', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

        model.onEditReview('レビュー!');
        model.debugState.when(
          (_, __, ___, ____, _____, ______, review, _______, ________,
              _________, __________, ___________, ____________) {
            expect(review, 'レビュー!');
          },
          loading: () {
            // ignore: avoid_print
            print('test is not passed');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });

      test('when input symbol', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

        model.onEditReview('🦆');
        model.debugState.when(
          (_, __, ___, ____, _____, ______, review, _______, ________,
              _________, __________, ___________, ____________) {
            expect(review, '🦆');
          },
          loading: () {
            // ignore: avoid_print
            print('test is not passed');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });
    });

    group('onEditEnglishReview', () {
      test('when input string', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

        model.onEditEnglishReview('review!');
        model.debugState.when(
          (_, __, ___, ____, _____, ______, _______, ________, enReview,
              _________, __________, ___________, ____________) {
            expect(enReview, 'review!');
          },
          loading: () {
            // ignore: avoid_print
            print('test is not passed');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });

      test('when input symbol', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

        model.onEditEnglishReview('🦆');
        model.debugState.when(
          (_, __, ___, ____, _____, ______, _______, ________, enReview,
              _________, __________, ___________, ____________) {
            expect(enReview, '🦆');
          },
          loading: () {
            // ignore: avoid_print
            print('test is not passed');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });
    });

    group('onEditPrice', () {
      test('when input number string', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

        model.onEditPrice('122334');
        model.debugState.when(
          (_, __, ___, ____, price, _____, ______, _______, ________, _________,
              __________, ___________, ____________) {
            expect(price, 122334);
          },
          loading: () {
            // ignore: avoid_print
            print('test is not passed');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });

      test('when empty', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

        model.onEditPrice('');
        model.debugState.when(
          (_, __, ___, ____, price, _____, ______, _______, ________, _________,
              __________, ___________, ____________) {
            expect(price, 0);
          },
          loading: () {
            // ignore: avoid_print
            print('test is not passed');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });
    });

    group('addFoodTag', () {
      test('when add the food tag of key 1', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

        model.addFoodTag(1);
        model.debugState.when(
          (_, __, ___, ____, ____________, _____, ______, _______, ________,
              _________, foodTags, __________, ___________) {
            expect(foodTags.length, 1);
          },
          loading: () {
            // ignore: avoid_print
            print('test is not passed');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });
    });

    group('removeFoodTag', () {
      test('when add the food tag of key 1', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

        // 'addFoodTag' でタグが一つ選択されている状態から始まる
        model.removeFoodTag(1);
        model.debugState.when(
          (_, __, ___, ____, ____________, _____, ______, _______, ________,
              _________, foodTags, __________, ___________) {
            expect(foodTags.length, 0);
          },
          loading: () {
            // ignore: avoid_print
            print('test is not passed');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });
    });

    group('selectPostUser', () {
      test('when select user1', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

        model.selectPostUser(1);
        model.debugState.when(
          (_, __, ___, ____, ____________, _____, ______, _______, ________,
                  _________, __________, postUser, ___________) =>
              expect(postUser, PostUsers.postUsers[1]),
          loading: () {
            // ignore: avoid_print
            print('test is not passed');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });
    });

    group('removePostUser', () {
      test('when select user1', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

        model.removeSelectedUser();
        model.debugState.when(
          (_, __, ___, ____, ____________, _____, ______, _______, ________,
                  _________, __________, postUser, ___________) =>
              expect(postUser, ''),
          loading: () {
            // ignore: avoid_print
            print('test is not passed');
          },
          error: () {
            // ignore: avoid_print
            print('test is not passed');
          },
        );
      });
    });

    group('postMenu', () {
      test('when the state is not _PostMenuState', () async {
        const shopId = 'shop_id_1';
        final model = container
            .read(postMenuProvider(const Tuple2(shopId, null)).notifier);

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

        expect(result, PostResults.abort);
      });
    });
  });
}
