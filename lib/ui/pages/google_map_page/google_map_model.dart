import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'google_map_model.freezed.dart';

@freezed
class GoogleMapState with _$GoogleMapState {
  factory GoogleMapState(
      {GoogleMapController? googleMapController,
      @Default([]) List<Shop> shopList}) = _GoogleMapState;

  factory GoogleMapState.creating() = _GoogleMapStateCreating;

  factory GoogleMapState.error() = _GoogleMapStateError;
}

class GoogleMapPageController extends StateNotifier<GoogleMapState> {
  GoogleMapPageController(this._shopUseCase) : super(GoogleMapState.creating());

  final ShopUseCase _shopUseCase;

  void onMapCreated(controller) async {
    state = GoogleMapState(googleMapController: controller);
  }

  Future<void> fetchShopsStream() async {
    if (state is _GoogleMapState) {
      final currentState = state as _GoogleMapState;

      final result = await _shopUseCase.fetchShopInMapStream(
          latitude: 34.998899, longitude: 135.766671, radius: 500.0);

      result.whenWithResult(
        (success) {
          _shopUseCase.shopUseCaseStreamController.stream.listen((event) {
            event.listen((list) {
              state = currentState.copyWith(shopList: list);
            });
          });
        },
        (e) {
          state = GoogleMapState.error();
        },
      );
    }
  }
}
