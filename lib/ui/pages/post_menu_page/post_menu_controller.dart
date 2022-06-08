import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:foodie_kyoto_post_app/constants/post_users_data.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/image_file_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_image_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_movie_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/movie_file_use_case.dart';
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

  factory PostMenuState.loading() = _PostMenuStateLoading;

  factory PostMenuState.error() = _PostMenuStateError;
}

class PostMenuController extends StateNotifier<PostMenuState> {
  PostMenuController(
      this._menuUseCase,
      this._menuImageUseCase,
      this._imageFileUseCase,
      this._pathUseCase,
      this._menuMovieUseCase,
      this._movieFileUSeCase,
      this._shopId,
      this._menu)
      : super(PostMenuState.loading()) {
    Future(() async => await initMenu());
  }

  final MenuUseCase _menuUseCase;
  final MenuImageUseCase _menuImageUseCase;
  final ImageFileUseCase _imageFileUseCase;
  final PathUseCase _pathUseCase;
  final MenuMovieUseCase _menuMovieUseCase;
  final MovieFileUseCase _movieFileUSeCase;
  final String _shopId;
  final Menu? _menu;

  Future<void> initMenu() async {
    if (_menu != null) {
      final List<File> _images = [];
      final menuImages = _menu!.images;
      for (int i = 0; i < menuImages.length; i++) {
        final _image = await urlToFile(menuImages[i], '$i', false);
        if (_image != null) {
          _images.add(_image);
        }
      }

      final menuMovie = _menu!.movies.first;
      final _movie = await urlToFile(menuMovie, '0', true);

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
        movies: _movie,
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

  Future<File?> urlToFile(
      String imageUrl, String fileName, bool isMovie) async {
    final tempDirResult = await _pathUseCase.getTempDirectory();

    return tempDirResult.whenWithResult(
      (path) async {
        String tempPath = path.value.path;
        final extension = isMovie ? '.mp4' : '.png';

        final File file = File('$tempPath/$fileName$extension');

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

  Future<void> selectMovie() async {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

      final movieResult = await _movieFileUSeCase.pickVideo();

      movieResult.whenWithResult(
        (movie) {
          if (movie.value != null) {
            state = currentState.copyWith(movies: movie.value);
          }
        },
        (e) => state = PostMenuState.error(),
      );
    }
  }

  Future<void> deleteSelectedMovie() async {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

      state = currentState.copyWith(movies: null);
    }
  }

  void addFoodTag(int key) {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

      state = currentState.copyWith(foodTags: currentState.foodTags + [key]);
    }
  }

  void removeFoodTag(int key) {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

      final foodTags = List.of(currentState.foodTags);
      foodTags.remove(key);

      state = currentState.copyWith(foodTags: foodTags);
    }
  }

  void selectPostUser(int key) {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

      final selectedUser = PostUsers.postUsers[key];

      if (selectedUser != null) {
        state = currentState.copyWith(postUser: selectedUser);
      }
    }
  }

  void removeSelectedUser() {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;
      state = currentState.copyWith(postUser: '');
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

  Future<String?> getMovieUrlFromStorage(String moviePath) async {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;
      final menuName = currentState.name;

      final putFileResult = await _menuMovieUseCase.postMovie(
          path: moviePath, shopId: _shopId, menuName: menuName, fileName: '0');

      return putFileResult.whenWithResult(
        (success) async {
          final urlResult = await _menuMovieUseCase.getMovieUrl(
              path: moviePath,
              shopId: _shopId,
              menuName: menuName,
              fileName: '0');

          return urlResult.whenWithResult(
            (url) => '${url.value}',
            (e) => null,
          );
        },
        (e) => null,
      );
    }
    return null;
  }

  Future<bool> deleteImageAndMovies() async {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

      final deleteImageResult = await _menuImageUseCase.deleteImages(
          shopId: _shopId, menuName: currentState.name);

      final deleteMovieResult = await _menuMovieUseCase.deleteMovies(
          shopId: _shopId, menuName: currentState.name);

      final isSuccessDeleteImage =
          deleteImageResult.whenWithResult((success) => true, (e) => false);
      final isSuccessDeleteMovie =
          deleteMovieResult.whenWithResult((success) => true, (e) => false);

      if (isSuccessDeleteImage && isSuccessDeleteMovie) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<PostResults> createOrModifyMenu() async {
    if (state is _PostMenuState) {
      final currentState = state as _PostMenuState;

      // 英語でのレビューは必須にはしない
      // 動画もいったん必須にしない
      if (currentState.review == '' || currentState.images == []) {
        return PostResults.empty;
      }

      state = currentState.copyWith(isPosting: true);

      final deleteResult = await deleteImageAndMovies();
      if (deleteResult) {
        final imagesUrl = await getImageUrlFromStorage(
            currentState.images.map((e) => e.path).toList());

        String movieUrl = '';
        if (currentState.movies != null) {
          final url = await getMovieUrlFromStorage(currentState.movies!.path);
          movieUrl = url ?? '';
        }

        if (imagesUrl.isNotEmpty) {
          final menu = Menu(
              menuId: _menu == null ? '' : _menu!.menuId,
              name: currentState.name,
              shopId: _shopId,
              images: imagesUrl,
              movies: [movieUrl],
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
      } else {
        state = currentState.copyWith(isPosting: false);
        return PostResults.error;
      }
    } else {
      return PostResults.abort;
    }
  }
}
