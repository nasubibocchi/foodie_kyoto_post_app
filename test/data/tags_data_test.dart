import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/constants/tags_data.dart';

void main() {
  test('Testing the service key value is not duplicated', () {
    final allServiceKeys = ServiceTags.serviceTags.keys.toList();

    final maxTagKeyValue = allServiceKeys.reduce(max);

    for (int i = 0; i < maxTagKeyValue; i++) {
      final keyCount = allServiceKeys.where((e) => e == i).toList().length;
      expect(keyCount == 0 || keyCount == 1, true);
    }
  });

  test('Testing the area key value is not duplicated', () {
    final allAreaKeys = AreaTags.areaTags.keys.toList();

    final maxTagKeyValue = allAreaKeys.reduce(max);

    for (int i = 0; i < maxTagKeyValue; i++) {
      final keyCount = allAreaKeys.where((e) => e == i).toList().length;
      expect(keyCount == 0 || keyCount == 1, true);
    }
  });

  test('Testing the food key value is not duplicated', () {
    final allFoodKeys = FoodTags.foodTags.keys.toList();

    final maxTagKeyValue = allFoodKeys.reduce(max);

    for (int i = 0; i < maxTagKeyValue; i++) {
      final keyCount = allFoodKeys.where((e) => e == i).toList().length;
      expect(keyCount == 0 || keyCount == 1, true);
    }
  });
}
