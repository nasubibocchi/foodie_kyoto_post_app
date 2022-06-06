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
      {required String name,
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

  factory PostMenuState.error() = _PostMenuStateError;
}

class PostMenuController extends StateNotifier<PostMenuState> {
  PostMenuController(this._menuUseCase, this._menuImageUseCase,
      this._imageFileUseCase, this._shopId, this._menu)
      : super(PostMenuState(
          name: '',
          nameController: TextEditingController(text: ''),
          priceController: TextEditingController(text: ''),
          reviewController: TextEditingController(text: ''),
          enReviewController: TextEditingController(text: ''),
        ));

  final MenuUseCase _menuUseCase;
  final MenuImageUseCase _menuImageUseCase;
  final ImageFileUseCase _imageFileUseCase;
  final String _shopId;
  final Menu? _menu;

  Future<void> initMenu() async {
    if (_menu != null) {
      state = PostMenuState(
        name: _menu!.name,
        nameController: TextEditingController.fromValue(TextEditingValue(
            text: _menu!.name,
            selection: TextSelection.collapsed(offset: _menu!.name.length))),
        priceController: TextEditingController.fromValue(TextEditingValue(
            text: '${_menu!.price}',
            selection:
                TextSelection.collapsed(offset: '${_menu!.price}'.length))),
        reviewController: TextEditingController.fromValue(TextEditingValue(
            text: _menu!.review,
            selection: TextSelection.collapsed(offset: _menu!.review.length))),
        enReviewController: TextEditingController.fromValue(TextEditingValue(
            text: _menu!.enReview,
            selection:
                TextSelection.collapsed(offset: _menu!.enReview.length))),
      );
    } else {
      final menu = Menu(
          name: '',
          shopId: _shopId,
          images: [],
          movies: [],
          foodTags: [],
          price: 0,
          review: '',
          enReview: '',
          postUser: '');

      state = PostMenuState(
        name: menu.name,
        nameController: TextEditingController.fromValue(TextEditingValue(
            text: menu.name,
            selection: TextSelection.collapsed(offset: menu.name.length))),
        priceController: TextEditingController.fromValue(TextEditingValue(
            text: '${menu.price}',
            selection:
                TextSelection.collapsed(offset: '${menu.price}'.length))),
        reviewController: TextEditingController.fromValue(TextEditingValue(
            text: menu.review,
            selection: TextSelection.collapsed(offset: menu.review.length))),
        enReviewController: TextEditingController.fromValue(TextEditingValue(
            text: menu.enReview,
            selection: TextSelection.collapsed(offset: menu.enReview.length))),
      );
    }
  }

  void onEditMenuName(String name) {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

      state = currentState.copyWith(name: name);
    }
  }

  void onEditReview(String review) {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

      state = currentState.copyWith(review: review);
    }
  }

  void onEditEnglishReview(String enReview) {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

      state = currentState.copyWith(enReview: enReview);
    }
  }

  void onEditPrice(String number) {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;
      final price = number == '' ? 0 : int.parse(number);

      state = currentState.copyWith(price: price);
    }
  }

  Future<void> selectImages() async {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;
      List<File> _imageList = currentState.images;

      final imagesResult = await _imageFileUseCase.pickMultiImage();

      imagesResult.whenWithResult(
        (images) {
          if (images.value.isNotEmpty) {
            state = currentState.copyWith(images: _imageList + images.value);
          }
        },
        (e) => state = PostMenuState.error(),
      );
    }
  }

  Future<void> changeImage(int index) async {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

      final List<File> dupImages = List.of(currentState.images);

      final imageResult = await _imageFileUseCase.pickImage();

      imageResult.whenWithResult(
        (image) {
          if (image.value != null) {
            dupImages[index] = image.value!;
            state = currentState.copyWith(images: dupImages);
          }
        },
        (e) => state = PostMenuState.error(),
      );
    }
  }

  void deleteSelectedImage(int index) {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

      final List<File> dupImages = List.of(currentState.images);

      dupImages.removeAt(index);

      state = currentState.copyWith(images: dupImages);
    }
  }

  Future<List<String>> getImageUrlFromStorage(List<String> imagePaths) async {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;
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
    } else {
      return <String>[];
    }
  }

  Future<PostResults> createOrModifyMenu() async {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

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
    } else {
      return PostResults.abort;
    }
  }
}
