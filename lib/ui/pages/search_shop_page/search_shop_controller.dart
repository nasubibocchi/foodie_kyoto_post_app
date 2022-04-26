import 'package:flutter/cupertino.dart';
import 'package:foodie_kyoto_post_app/app_config.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/places_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'search_shop_controller.freezed.dart';

@freezed
class SearchShopState with _$SearchShopState {
  factory SearchShopState({
    required String? searchText,
    List<String>? searchResultList,
    required TextEditingController searchController,
  }) = _SearchShopState;
}

class SearchShopController extends StateNotifier<SearchShopState> {
  SearchShopController(this._placesUseCase)
      : super(SearchShopState(
          searchText: null,
          searchController: TextEditingController(text: null),
        )) {
    _initGooglePlaces();
    state.searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: state.searchController.text.length));
  }

  final PlacesUseCase _placesUseCase;

  void _initGooglePlaces() {
    if (appConfig.placesApiKey != null) {
      _placesUseCase.initGooglePlaces(apiKey: appConfig.placesApiKey!);
    }
  }

  Future<void> searchShops() async {
    final currentState = state;

    final searchText = currentState.searchController.text;

    final shopResponse =
        await _placesUseCase.searchShopsByAutoComplete(body: searchText);

    shopResponse.whenWithResult((searchResultList) {
      state = currentState.copyWith(searchResultList: searchResultList.value);
    }, (e) {
      // error handling
    });
  }

  void onEditSearchText(String body) {
    final currentState = state;
    state = currentState.copyWith(searchText: body);
  }
}
