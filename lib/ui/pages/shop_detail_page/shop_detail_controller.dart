import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'shop_detail_controller.freezed.dart';

@freezed
class ShopDetailState with _$ShopDetailState {
  factory ShopDetailState({required List<Menu> menu}) = _ShopDetailState;

  factory ShopDetailState.loading() = _ShopDetailStateLoading;

  factory ShopDetailState.error() = _ShopDetailStateError;
}

class ShopDetailController extends StateNotifier<ShopDetailState> {
  ShopDetailController(this._menuUseCase, this._shopId)
      : super(ShopDetailState.loading()) {
    fetchShopMenus();
  }

  final MenuUseCase _menuUseCase;
  final String _shopId;

  Future<void> fetchShopMenus() async {
    final menuResult = await _menuUseCase.fetchShopMenus(shopId: _shopId);

    menuResult.whenWithResult(
      (success) {
        final menu = success.value;
        state = ShopDetailState(menu: menu);
      },
      (e) => state = ShopDetailState.error(),
    );
  }
}
