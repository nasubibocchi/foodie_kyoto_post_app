import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/image_file_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_image_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_controller.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'post_menu_controller.freezed.dart';

@freezed
class PostMenuState with _$PostMenuState {
  factory PostMenuState(
      {required Menu? menu,
      required String name,
      required TextEditingController nameController,
      @Default([]) List<File> images,
      File? movies,
      @Default(0) int price,
      required TextEditingController priceController,
      @Default('') String review,
      required TextEditingController reviewController,
      @Default('') String enReview,
      required TextEditingController enReviewController,
      @Default([]) List<int> foodTags,
      @Default('') String postUser,
      @Default(false) bool isPosting}) = _PostMenuState;
}

class PostMenuController extends StateNotifier<PostMenuState> {
  PostMenuController(this._menuUseCase, this._menuImageUseCase,
      this._imageFileUseCase, this._shopId)
      : super(PostMenuState(
          menu: null,
          name: '',
          nameController: TextEditingController(text: ''),
          priceController: TextEditingController(text: ''),
          reviewController: TextEditingController(text: ''),
          enReviewController: TextEditingController(text: ''),
        )) {
    state.nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: state.nameController.text.length));
    state.priceController.selection = TextSelection.fromPosition(
        TextPosition(offset: state.priceController.text.length));
    state.reviewController.selection = TextSelection.fromPosition(
        TextPosition(offset: state.reviewController.text.length));
    state.enReviewController.selection = TextSelection.fromPosition(
        TextPosition(offset: state.enReviewController.text.length));
  }

  final MenuUseCase _menuUseCase;
  final MenuImageUseCase _menuImageUseCase;
  final ImageFileUseCase _imageFileUseCase;
  final String _shopId;

  void onEditMenuName(String name) {
    final currentState = state;

    state = currentState.copyWith(name: name);
  }

  void onEditReview(String review) {
    final currentState = state;

    state = currentState.copyWith(review: review);
  }

  void onEditEnglishReview(String enReview) {
    final currentState = state;

    state = currentState.copyWith(enReview: enReview);
  }

  void onEditPrice(String number) {
    final currentState = state;
    final price = number == '' ? 0 : int.parse(number);

    state = currentState.copyWith(price: price);
  }

  Future<void> selectImages() async {
    final currentState = state;
    List<File> _imageList = currentState.images;

    final imagesResult = await _imageFileUseCase.pickMultiImage();

    imagesResult.whenWithResult(
      (images) {
        if (images.value.isNotEmpty) {
          state = currentState.copyWith(images: _imageList + images.value);
        }
      },
      (e) {
        // errorが発生したらstateをエラー状態にしたいが、
        // loading(メニュー編集機能で作成予定)stateとあわせて作りたいので
        // いったん何もしない
      },
    );
  }

  Future<void> changeImage(int index) async {
    final currentState = state;

    final List<File> dupImages = List.of(currentState.images);

    final imageResult = await _imageFileUseCase.pickImage();

    imageResult.whenWithResult(
      (image) {
        if (image.value != null) {
          dupImages[index] = image.value!;
          state = currentState.copyWith(images: dupImages);
        }
      },
      (e) {
        // errorが発生したらstateをエラー状態にしたいが、
        // loading(メニュー編集機能で作成予定)stateとあわせて作りたいので
        // いったん何もしない
      },
    );
  }

  void deleteSelectedImage(int index) {
    final currentState = state;

    final List<File> dupImages = List.of(currentState.images);

    dupImages.removeAt(index);

    state = currentState.copyWith(images: dupImages);
  }

  Future<List<String>> getImageUrlFromStorage(List<String> imagePaths) async {
    final currentState = state;
    final menuName = currentState.name;

    for (int i = 0; i < imagePaths.length; i++) {
      await _menuImageUseCase.postImages(
          path: imagePaths[i],
          shopId: _shopId,
          menuName: menuName,
          fileName: '$i');
    }

    final List<String> _imageUrlList = <String>[];
    for (int i = 0; i < imagePaths.length; i++) {
      final urlResult = await _menuImageUseCase.getImagesUrl(
          path: imagePaths[i],
          shopId: _shopId,
          menuName: menuName,
          fileName: '$i');

      urlResult.whenWithResult((url) {
        if (url.value != null) {
          _imageUrlList.add(url.value!);
        }
      }, (failure) {});
    }
    return _imageUrlList;
  }

  Future<PostResults> createOrModifyMenu() async {
    final currentState = state;

    // 英語でのレビューは必須にはしない
    if (currentState.review == '' ||
        currentState.images == [] ||
        currentState.movies == null) {
      return PostResults.empty;
    }

    final menu = Menu(
        name: currentState.name,
        shopId: _shopId,
        // images, moviesのコントローラは別途作る
        images: [],
        movies: [],
        foodTags: currentState.foodTags,
        price: currentState.price,
        review: currentState.review,
        enReview: currentState.enReview,
        postUser: currentState.postUser);

    final result = await _menuUseCase.createMenu(menu: menu);

    return result.whenWithResult(
        (success) => PostResults.success, (e) => PostResults.error);
  }
}
