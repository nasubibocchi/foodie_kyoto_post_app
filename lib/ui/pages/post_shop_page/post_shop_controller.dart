import 'package:flutter/cupertino.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'post_shop_controller.freezed.dart';

@freezed
class PostShopState with _$PostShopState {
  factory PostShopState({
    required Shop? shop,
    required TextEditingController commentController,
  }) = _PostShopState;

  factory PostShopState.loading() = _PostShopStateLoading;

  factory PostShopState.error() = _PostShopStateError;
}

class PostShopController extends StateNotifier<PostShopState> {
  PostShopController(this._shopUseCase, this._shopId)
      : super(PostShopState.loading()) {
    initShopState();
  }

  final ShopUseCase _shopUseCase;
  final String _shopId;

  Future<void> initShopState() async {
    final shopResult = await _shopUseCase.fetchShopByShopId(shopId: _shopId);

    shopResult.whenWithResult((shop) {
      if (shop.value != null) {
        state = PostShopState(
          shop: shop.value,
          commentController: TextEditingController(text: shop.value!.comment),
        );
      } else {
        final shop = Shop(
            name: '',
            shopId: _shopId,
            latitude: 0.0,
            longitude: 0.0,
            comment: '',
            images: [],
            tags: []);
        state = PostShopState(
            shop: shop,
            commentController: TextEditingController(text: shop.comment));
      }
    }, (e) {
      state = PostShopState.error();
    });
  }

  void editComment(String? body) {
    if (state is _PostShopState) {
      final currentState = state as _PostShopState;
      if (currentState.shop == null) {
        return;
      }

      final comment = body ?? '';

      final shop = Shop(
          name: currentState.shop!.name,
          shopId: currentState.shop!.shopId,
          latitude: currentState.shop!.latitude,
          longitude: currentState.shop!.longitude,
          comment: comment,
          images: currentState.shop!.images,
          tags: currentState.shop!.tags);

      state = currentState.copyWith(
          shop: shop,
          commentController: TextEditingController(text: shop.comment));
    }
  }
}
