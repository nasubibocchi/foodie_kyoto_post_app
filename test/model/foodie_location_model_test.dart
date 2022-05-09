import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/foodie_location_model.dart';

void main() {
  const double latitude = 50.0;
  const double longitude = 135.0;

  final Map<String, dynamic> data = {
    'latitude': latitude,
    'longitude': longitude,
  };

  test('fromJson', () {
    final ref = FoodieLocationModel(latitude: latitude, longitude: longitude);
    final actual = FoodieLocationModel.fromJson(data);

    expect(actual.latitude, ref.latitude);
    expect(actual.longitude, ref.longitude);
  });

  test('copyWith', () {
    final ref = FoodieLocationModel(latitude: latitude, longitude: longitude);
    final actual =
        ref.copyWith(latitude: ref.latitude, longitude: ref.longitude);

    expect(actual.latitude, ref.latitude);
    expect(actual.longitude, ref.longitude);
  });

  test('toJson()', () {
    final actual =
        FoodieLocationModel(latitude: latitude, longitude: longitude).toJson();

    expect(actual, isA<Map<String, dynamic>>());
  });

  test('toString()', () {
    final actual = FoodieLocationModel(latitude: latitude, longitude: longitude)
        .toString();

    expect(actual, isA<String>());
  });
}
