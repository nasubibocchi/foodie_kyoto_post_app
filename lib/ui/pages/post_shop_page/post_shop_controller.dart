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
    @Default([]) List<XFile> images,
  }) = _PostShopState;

  factory PostShopState.loading() = _PostShopStateLoading;

  factory PostShopState.error() = _PostShopStateError;
}

// shopのstateを変更するのは「投稿」ボタンをタップ直後、Firestoreに保存する直前だけにする。
class PostShopController extends StateNotifier<PostShopState> {
  PostShopController(this._shopUseCase, this._placesUseCase, this._shopId)
      : super(PostShopState.loading()) {
    initShopState();
  }

  final ShopUseCase _shopUseCase;
  final PlacesUseCase _placesUseCase;
  final String _shopId;

  final ImagePicker _picker = ImagePicker();

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
              serviceTags: <int>[],
              areaTags: <int>[],
              foodTags: <int>[],
              postUser: '');

          state = PostShopState(
              shop: shop,
              commentController: TextEditingController.fromValue(
                  TextEditingValue(
                      text: shop.comment,
                      selection: TextSelection.collapsed(
                          offset: shop.comment.length))),
              comment: shop.comment,
              images: []);
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

      state = currentState.copyWith(comment: body);
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

  Future<void> selectImages() async {
    if (state is _PostShopState) {
      final currentState = state as _PostShopState;
      List<XFile> _imageList = currentState.images;

      final _images = await _picker.pickMultiImage();
      if (_images != null) {
        state = currentState.copyWith(images: _imageList + _images);
      }
    }
  }

  Future<void> changeImage(int index) async {
    if (state is _PostShopState) {
      final currentState = state as _PostShopState;

      List<XFile>? dupImages = currentState.images;

      final _image = await _picker.pickImage(source: ImageSource.gallery);
      if (_image != null) {
        dupImages[index] = _image;
        state = currentState.copyWith(images: dupImages);
      }
    }
  }
}
