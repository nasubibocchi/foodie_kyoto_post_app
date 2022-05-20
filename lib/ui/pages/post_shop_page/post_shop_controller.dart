import 'package:flutter/cupertino.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop_detail.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/places_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

part 'post_shop_controller.freezed.dart';

@freezed
class PostShopState with _$PostShopState {
  factory PostShopState({
    required Shop? shop,
    required TextEditingController commentController,
    required String? comment,
    required List<XFile>? images,
  }) = _PostShopState;

  factory PostShopState.loading() = _PostShopStateLoading;

  factory PostShopState.error() = _PostShopStateError;
}

class PostShopController extends StateNotifier<PostShopState> {
  PostShopController(this._shopUseCase, this._placesUseCase, this._shopId)
      : super(PostShopState.loading()) {
    initShopState();
  }

  final ShopUseCase _shopUseCase;
  final PlacesUseCase _placesUseCase;
  final String _shopId;

  Future<void> initShopState() async {
    final shopResult = await _shopUseCase.fetchShopByShopId(shopId: _shopId);

    shopResult.whenWithResult((data) async {
      if (data.value != null) {
        final _images = data.value!.images.map((e) => XFile(e)).toList();

        state = PostShopState(
          shop: data.value,
          commentController: TextEditingController.fromValue(TextEditingValue(
              text: data.value!.comment,
              selection:
                  TextSelection.collapsed(offset: data.value!.comment.length))),
          comment: data.value!.comment,
          images: _images,
        );
      } else {
        final shopDetail = await fetchShopDetail();

        if (shopDetail != null) {
          final shop = Shop(
              name: shopDetail.name,
              shopId: _shopId,
              latitude: shopDetail.latitude,
              longitude: shopDetail.longitude,
              comment: '',
              images: [],
              tags: [],
              postUser: '');

          state = PostShopState(
              shop: shop,
              commentController: TextEditingController.fromValue(
                  TextEditingValue(
                      text: shop.comment,
                      selection: TextSelection.collapsed(
                          offset: shop.comment.length))),
              comment: shop.comment,
              images: null);
        } else {
          state = PostShopState.error();
        }
      }
    }, (e) {
      state = PostShopState.error();
    });
  }

  void editComment(String body) {
    if (state is _PostShopState) {
      final currentState = state as _PostShopState;
      if (currentState.shop == null) {
        return;
      }

      final shop = Shop(
          name: currentState.shop!.name,
          shopId: currentState.shop!.shopId,
          latitude: currentState.shop!.latitude,
          longitude: currentState.shop!.longitude,
          comment: body,
          images: currentState.shop!.images,
          tags: currentState.shop!.tags,
          postUser: currentState.shop!.postUser);

      state = currentState.copyWith(shop: shop, comment: body);
    }
  }

  Future<ShopDetail?> fetchShopDetail() async {
    final shopDetailResult =
        await _placesUseCase.searchShopDetailsByPlaceId(placeId: _shopId);

    ShopDetail? shopDetail;

    shopDetailResult.whenWithResult((detail) {
      shopDetail = detail.value;
    }, (e) {
      shopDetail = null;
    });

    return shopDetail;
  }
}
