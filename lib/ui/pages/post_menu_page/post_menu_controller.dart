import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/image_file_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_image_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/path_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_controller.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

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
      this._imageFileUseCase, this._pathUseCase, this._shopId, this._menu)
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
  final PathUseCase _pathUseCase;
  final String _shopId;
  final Menu? _menu;

  Future<void> initMenu() async {
    if (_menu != null) {
      final List<File> _images = [];
      final menuImages = _menu!.images;
      for (int i = 0; i < menuImages.length; i++) {
        final _image = await urlToFile(menuImages[i], '$i');
        if (_image != null) {
          _images.add(_image);
        }
      }

      state = PostMenuState(
        name: _menu!.name,
        nameController: TextEditingController.fromValue(TextEditingValue(
            text: _menu!.name,
            selection: TextSelection.collapsed(offset: _menu!.name.length))),
        price: _menu!.price,
        priceController: TextEditingController.fromValue(TextEditingValue(
            text: '${_menu!.price}',
            selection:
                TextSelection.collapsed(offset: '${_menu!.price}'.length))),
        review: _menu!.review,
        reviewController: TextEditingController.fromValue(TextEditingValue(
            text: _menu!.review,
            selection: TextSelection.collapsed(offset: _menu!.review.length))),
        enReview: _menu!.enReview,
        enReviewController: TextEditingController.fromValue(TextEditingValue(
            text: _menu!.enReview,
            selection:
                TextSelection.collapsed(offset: _menu!.enReview.length))),
        images: _images,
        // 動画を登録できるようにしたら初期化処理を入れる
        movies: null,
        foodTags: _menu!.foodTags,
        postUser: _menu!.postUser,
      );
    } else {
      final menu = Menu(
          menuId: '',
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

  Future<File?> urlToFile(String imageUrl, String fileName) async {
    final tempDirResult = await _pathUseCase.getTempDirectory();

    return tempDirResult.whenWithResult(
      (path) async {
        String tempPath = path.value.path;

        final File file = File('$tempPath/$fileName.png');

        final url = Uri.parse(imageUrl);
        final http.Response response = await http.get(url);

        await file.writeAsBytes(response.bodyBytes);

        return file;
      },
      (e) {
        state = PostMenuState.error();
        return null;
      },
    );
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

      state = currentState.copyWith(isPosting: true);

      final deleteResult = await _menuImageUseCase.deleteImages(
          shopId: _shopId, menuName: currentState.name);

      return deleteResult.whenWithResult((success) async {
        final imagesUrl = await getImageUrlFromStorage(
            currentState.images.map((e) => e.path).toList());

        if (imagesUrl.isNotEmpty) {
          final menu = Menu(
              menuId: _menu == null ? '' : _menu!.menuId,
              name: currentState.name,
              shopId: _shopId,
              // moviesのコントローラは別途作る
              images: imagesUrl,
              movies: [],
              foodTags: currentState.foodTags,
              price: currentState.price,
              review: currentState.review,
              enReview: currentState.enReview,
              postUser: currentState.postUser);

          final result = await _menuUseCase.postMenu(menu: menu);
          state = currentState.copyWith(isPosting: false);

          return result.whenWithResult(
              (success) => PostResults.success, (e) => PostResults.error);
        } else {
          state = currentState.copyWith(isPosting: false);
          return PostResults.error;
        }
      }, (e) {
        state = currentState.copyWith(isPosting: false);
        return PostResults.error;
      });
    } else {
      return PostResults.abort;
    }
  }
}
