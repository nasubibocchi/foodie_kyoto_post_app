import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_controller.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_provider.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';

import 'post_menu_controller.mocks.dart';

@GenerateMocks([MenuUseCase])
void main() {
  final _menuUseCase = MockMenuUseCase();
  final container = ProviderContainer(overrides: [
    postMenuProvider.overrideWithProvider(
        StateNotifierProvider.family<PostMenuController, PostMenuState, String>(
            (ref, _shopId) => PostMenuController(_menuUseCase, _shopId))),
  ]);

  group('postMenu', () {
    test('when review comment is empty', () async {
      const shopId = 'shop_id_1';
      final model = container.read(postMenuProvider(shopId).notifier);

      model.onEditMenuName('name');
      model.onEditPrice('300');
      model.onEditReview('review');

      final result = await model.createOrModifyMenu();

      expect(result, PostResults.empty);
    });
  });
}
