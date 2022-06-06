import 'package:foodie_kyoto_post_app/domain/use_case/menu_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/shop_detail_page/shop_detail_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final shopDetailProvider =
    StateNotifierProvider.family<ShopDetailController, ShopDetailState, String>(
        (ref, _shopId) =>
            ShopDetailController(ref.read(menuUseCaseProvider), _shopId));
