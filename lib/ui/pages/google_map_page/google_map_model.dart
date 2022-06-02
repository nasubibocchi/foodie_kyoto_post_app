import 'dart:math';

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

      final radius = await getMapRadiusMeter();
      final centerLatLng = await getCenterLocation();

      if (centerLatLng != null) {
        final result = await _shopUseCase.fetchShopInMapStream(
            latitude: centerLatLng.latitude,
            longitude: centerLatLng.longitude,
            radius: radius);

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
      } else {
        state = GoogleMapState.error();
      }
    }
  }

  Future<LatLng?> getCenterLocation() async {
    if (state is _GoogleMapState) {
      final currentState = state as _GoogleMapState;
      final controller = currentState.googleMapController;

      final region = await controller?.getVisibleRegion();
      if (region != null) {
        final centerLat =
            (region.northeast.latitude + region.southwest.latitude) / 2;
        final centerLng =
            (region.northeast.longitude + region.southwest.longitude) / 2;

        return LatLng(centerLat, centerLng);
      }
      return null;
    }
    return null;
  }

  Future<double?> getZoomLevel() async {
    if (state is _GoogleMapState) {
      final currentState = state as _GoogleMapState;
      final controller = currentState.googleMapController;

      final zoomLevel = await controller?.getZoomLevel();
      return zoomLevel;
    }
    return null;
  }

  Future<double> getMapRadiusMeter() async {
    double mapRadiusM = 150000;
    final zoomLevel = await getZoomLevel();
    if (zoomLevel != null) {
      final _zoomLevel = zoomLevel;
      if (_zoomLevel > 8) {
        mapRadiusM = mapRadiusM / pow(2, _zoomLevel - 8);
      }
    }
    return mapRadiusM;
  }
}
