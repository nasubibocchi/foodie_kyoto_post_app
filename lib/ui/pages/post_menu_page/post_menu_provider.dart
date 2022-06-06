import 'package:foodie_kyoto_post_app/domain/use_case/menu_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postMenuProvider =
    StateNotifierProvider.family<PostMenuController, PostMenuState, String>(
        (ref, shopId) =>
            PostMenuController(ref.read(menuUseCaseProvider), shopId));
