import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/foodie_prediction_model.dart';

void main() {
  final data = [
    {
      'description': 'a',
      'place_id': 'string1',
    },
    {
      'description': 'b',
      'place_id': 'string2',
    }
  ];

  test('FoodiePredictionModel.fromJson', () {
    final test = FoodiePredictionModel.fromJson(data.first);

    final actual = FoodiePredictionModel(description: 'a', placeId: 'string1');

    expect(actual.description, test.description);
    expect(actual.placeId, test.placeId);
  });

  group('copyWith', () {
    test('copyWith = original', () {
      final original =
          FoodiePredictionModel(description: 'a', placeId: 'string1');

      final copyWith = original.copyWith(
          description: original.description, placeId: original.placeId);

      expect(copyWith.description, original.description);
      expect(copyWith.placeId, original.placeId);
    });

    test('copyWith != original', () {
      final original = FoodiePredictionModel(
        description: 'b',
        placeId: 'string2',
      );
      final copyWith = original.copyWith(
          description: original.description, placeId: original.description);

      expect(copyWith.placeId, isNot(original.placeId));
    });
  });

  test('toJson()', () {
    final original =
        FoodiePredictionModel(description: 'a', placeId: 'string1');

    final json = original.toJson();
    expect(json, isA<Map<String, dynamic>>());
  });

  test('toString()', () {
    final original =
        FoodiePredictionModel(description: 'a', placeId: 'string1');

    final json = original.toString();
    expect(json, isA<String>());
  });
}
