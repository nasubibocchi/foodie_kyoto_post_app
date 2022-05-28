import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop_detail.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/places_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_image_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

part 'post_shop_controller.freezed.dart';

@freezed
class PostShopState with _$PostShopState {
  factory PostShopState({
    required Shop? shop,
    required TextEditingController commentController,
    required String? comment,
    @Default([]) List<XFile> images,
    @Default([]) List<int> selectedServiceTags,
    @Default([]) List<int> selectedAreaTags,
    @Default([]) List<int> selectedFoodTags,
  }) = _PostShopState;

  factory PostShopState.loading() = _PostShopStateLoading;

  factory PostShopState.error() = _PostShopStateError;
}

enum PostResults {
  abort,
  empty,
  success,
  error,
}

// shopのstateを変更するのは「投稿」ボタンをタップ直後、Firestoreに保存する直前だけにする。
class PostShopController extends StateNotifier<PostShopState> {
  PostShopController(this._shopUseCase, this._placesUseCase,
      this._shopImageUseCase, this._shopId)
      : super(PostShopState.loading()) {
    initShopState();
  }

  final ShopUseCase _shopUseCase;
  final PlacesUseCase _placesUseCase;
  final ShopImageUseCase _shopImageUseCase;
  final String _shopId;

  final ImagePicker _picker = ImagePicker();

  Future<void> initShopState() async {
    final shopResult = await _shopUseCase.fetchShopByShopId(shopId: _shopId);

    shopResult.whenWithResult((data) async {
      if (data.value != null) {
        final List<XFile> _images = [];
        final shopImages = data.value!.images;
        for (int i = 0; i < shopImages.length; i++) {
          final _image = await _urlToXFile(shopImages[i], '$i');
          _images.add(_image);
        }

        state = PostShopState(
          shop: data.value,
          commentController: TextEditingController.fromValue(TextEditingValue(
              text: data.value!.comment,
              selection:
                  TextSelection.collapsed(offset: data.value!.comment.length))),
          comment: data.value!.comment,
          images: _images,
          selectedServiceTags: data.value!.serviceTags,
          selectedAreaTags: data.value!.areaTags,
          selectedFoodTags: data.value!.foodTags,
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

  Future<XFile> _urlToXFile(String imageUrl, String fileName) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final File file = File('$tempPath/$fileName.png');

    final url = Uri.parse(imageUrl);
    final http.Response response = await http.get(url);

    await file.writeAsBytes(response.bodyBytes);

    final xFile = XFile(file.path);
    return xFile;
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

  void addServiceTag(int key) {
    if (state is _PostShopState) {
      final currentState = state as _PostShopState;

      state = currentState.copyWith(
          selectedServiceTags: currentState.selectedServiceTags + [key]);
    }
  }

  void removeServiceTag(int key) {
    if (state is _PostShopState) {
      final currentState = state as _PostShopState;

      final selectedServiceTags = List.of(currentState.selectedServiceTags);
      selectedServiceTags.remove(key);

      state = currentState.copyWith(selectedServiceTags: selectedServiceTags);
    }
  }

  void addAreaTag(int key) {
    if (state is _PostShopState) {
      final currentState = state as _PostShopState;

      state = currentState.copyWith(
          selectedAreaTags: currentState.selectedAreaTags + [key]);
    }
  }

  void removeAreaTag(int key) {
    if (state is _PostShopState) {
      final currentState = state as _PostShopState;

      final selectedAreaTags = List.of(currentState.selectedAreaTags);
      selectedAreaTags.remove(key);

      state = currentState.copyWith(selectedAreaTags: selectedAreaTags);
    }
  }

  void addFoodTag(int key) {
    if (state is _PostShopState) {
      final currentState = state as _PostShopState;

      state = currentState.copyWith(
          selectedFoodTags: currentState.selectedFoodTags + [key]);
    }
  }

  void removeFoodTag(int key) {
    if (state is _PostShopState) {
      final currentState = state as _PostShopState;

      final selectedFoodTags = List.of(currentState.selectedFoodTags);
      selectedFoodTags.remove(key);

      state = currentState.copyWith(selectedFoodTags: selectedFoodTags);
    }
  }

  Future<PostResults> postShop() async {
    if (state is _PostShopState) {
      final currentState = state as _PostShopState;
      if (currentState.shop == null) {
        return PostResults.abort;
      }

      if (currentState.comment == '' || currentState.images.isEmpty) {
        return PostResults.empty;
      }
      // コメントが空白、または画像を設定しないまま保存しない

      final deleteResult =
          await _shopImageUseCase.deleteImages(shopId: _shopId);

      return deleteResult.whenWithResult((success) async {
        final imagesUrl = await getImageUrlFromStorage(
            currentState.images.map((e) => e.path).toList());

        if (imagesUrl.isNotEmpty) {
          final shop = Shop(
              name: currentState.shop!.name,
              shopId: _shopId,
              latitude: currentState.shop!.latitude,
              longitude: currentState.shop!.longitude,
              comment: currentState.comment!,
              images: imagesUrl,
              serviceTags: currentState.selectedServiceTags,
              areaTags: currentState.selectedAreaTags,
              foodTags: currentState.selectedFoodTags,
              postUser: 'postUser');
          // 別issueで登録者ボタンを作るまではとりあえずStringを入れておく。

          final result = await _shopUseCase.postShop(shop: shop);
          return result.whenWithResult(
            (success) => PostResults.success,
            (e) => PostResults.error,
          );
        } else {
          return PostResults.empty;
        }
      }, (e) => PostResults.error);
    } else {
      return PostResults.abort;
    }
  }

  Future<List<String>> getImageUrlFromStorage(List<String> imagePaths) async {
    if (state is _PostShopState) {
      for (int i = 0; i < imagePaths.length; i++) {
        await _shopImageUseCase.postImages(
            path: imagePaths[i], shopId: _shopId, fileName: '$i');
      }

      final List<String> _imageUrlList = <String>[];
      for (int i = 0; i < imagePaths.length; i++) {
        final urlResult = await _shopImageUseCase.getImagesUrl(
            path: imagePaths[i], shopId: _shopId, fileName: '$i');
        urlResult.whenWithResult((url) {
          if (url.value != null) {
            _imageUrlList.add(url.value!);
          }
        }, (failure) {});
      }
      return _imageUrlList;
    } else {
      return <String>[];
    }
  }
}
