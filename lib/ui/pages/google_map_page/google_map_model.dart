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
      {required GoogleMapController googleMapController,
      @Default([]) List<Shop> shopList,
      @Default(false) bool isShowingShopInformation}) = _GoogleMapState;

  factory GoogleMapState.creating() = _GoogleMapStateCreating;

  factory GoogleMapState.error() = _GoogleMapStateError;
}

class GoogleMapPageController extends StateNotifier<GoogleMapState> {
  GoogleMapPageController(this._shopUseCase) : super(GoogleMapState.creating());

  final ShopUseCase _shopUseCase;

  void onMapCreated(GoogleMapController controller) {
    state = GoogleMapState(googleMapController: controller);
  }

  Future<void> fetchShopsStream() async {
    if (state is _GoogleMapState) {
      final currentState = state as _GoogleMapState;

      // // 一旦京都市のデータ全件取得する。データが増えて来たら変更予定。
      // final radius = await getMapRadiusKiloMeter();
      // final centerLatLng = await getCenterLocation();

      // if (centerLatLng != null) {

      const kyotoRadius = 25.5;
      const kyotoCenterLat = 35.0813;
      const kyotoCenterLng = 135.4743;

      final result = await _shopUseCase.fetchShopInMapStream(
          latitude: kyotoCenterLat,
          longitude: kyotoCenterLng,
          radius: kyotoRadius);

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
      // } else {
      //   state = GoogleMapState.error();
      // }
    }
  }

  void setShowingShopInformation(bool isShowing) {
    if (state is _GoogleMapState) {
      final currentState = state as _GoogleMapState;

      state = currentState.copyWith(isShowingShopInformation: isShowing);
    }
  }

  Future<void> onSwipeShopInfo(int index) async {
    if (state is _GoogleMapState) {
      final zoomLevel = await getZoomLevel();

      final currentState = state as _GoogleMapState;

      final latLng = LatLng(currentState.shopList[index].latitude,
          currentState.shopList[index].longitude);

      if (zoomLevel != null) {
        final cameraPosition = CameraPosition(target: latLng, zoom: zoomLevel);
        final cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition);
        final _markerId = MarkerId(currentState.shopList[index].shopId);

        currentState.googleMapController.showMarkerInfoWindow(_markerId);
        currentState.googleMapController.animateCamera(cameraUpdate);
      }
    }
  }

  Future<LatLng?> getCenterLocation() async {
    if (state is _GoogleMapState) {
      final currentState = state as _GoogleMapState;
      final controller = currentState.googleMapController;

      final region = await controller.getVisibleRegion();
      final centerLat =
          (region.northeast.latitude + region.southwest.latitude) / 2;
      final centerLng =
          (region.northeast.longitude + region.southwest.longitude) / 2;

      return LatLng(centerLat, centerLng);
    }
    return null;
  }

  Future<double?> getZoomLevel() async {
    if (state is _GoogleMapState) {
      final currentState = state as _GoogleMapState;
      final controller = currentState.googleMapController;

      final zoomLevel = await controller.getZoomLevel();
      return zoomLevel;
    }
    return null;
  }

  Future<double> getMapRadiusKiloMeter() async {
    double mapRadiusM = 150000;
    final zoomLevel = await getZoomLevel();
    if (zoomLevel != null) {
      final _zoomLevel = zoomLevel;
      if (_zoomLevel > 8) {
        mapRadiusM = mapRadiusM / pow(2, _zoomLevel - 8);
      }
    }
    return mapRadiusM / 1000;
  }
}
