import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/constants/tags_data.dart';

void main() {
  test('Testing the each key value is not duplicated', () {
    final allTagKeys = ServiceTags.serviceTags.keys.toList() +
        AreaTags.areaTags.keys.toList() +
        FoodTags.foodTags.keys.toList();

    final maxTagKeyValue = allTagKeys.reduce(max);

    for (int i = 0; i < maxTagKeyValue; i++) {
      final keyCount = allTagKeys.where((e) => e == i).toList().length;
      expect(keyCount == 0 || keyCount == 1, true);
    }
  });
}
