import 'package:flutter/material.dart';

@immutable
class ServiceTags {
  static const Map<int, String> serviceTags = {
    1: '電子マネー',
    2: '交通系',
  };
}

@immutable
class AreaTags {
  static const Map<int, String> areaTags = {
    3: '東山区',
    4: '西京区',
  };
}

@immutable
class FoodTags {
  static const Map<int, String> foodTags = {
    5: '肉',
    6: '寿司',
  };
}
