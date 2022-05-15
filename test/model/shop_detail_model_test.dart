import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/shop_detail_model.dart';

void main() {
  const String name = 'shop1';
  const double latitude = 50.0;
  const double longitude = 135.0;

  final Map<String, dynamic> data = {
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
  };

  test('fromJson', () {
    final ref =
        ShopDetailModel(name: name, latitude: latitude, longitude: longitude);
    final actual = ShopDetailModel.fromJson(data);

    expect(actual.latitude, ref.latitude);
    expect(actual.longitude, ref.longitude);
  });

  test('copyWith', () {
    final ref =
        ShopDetailModel(name: name, latitude: latitude, longitude: longitude);
    final actual =
        ref.copyWith(latitude: ref.latitude, longitude: ref.longitude);

    expect(actual.latitude, ref.latitude);
    expect(actual.longitude, ref.longitude);
  });

  test('toJson()', () {
    final actual =
        ShopDetailModel(name: name, latitude: latitude, longitude: longitude)
            .toJson();

    expect(actual, isA<Map<String, dynamic>>());
  });

  test('toString()', () {
    final actual =
        ShopDetailModel(name: name, latitude: latitude, longitude: longitude)
            .toString();

    expect(actual, isA<String>());
  });
}
