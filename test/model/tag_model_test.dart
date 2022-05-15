import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/tag_model.dart';

void main() {
  final data = [
    {
      'id': 1,
      'name': 'kiyomizudera',
    },
    {
      'id': 2,
      'name': 'kinkakuji',
    }
  ];

  test('from json', () {
    final ref = [
      TagModel(id: 1, name: 'kiyomizudera'),
      TagModel(id: 2, name: 'kinkakuji')
    ];
    final actual = data.map((e) => TagModel.fromJson(e)).toList();

    expect(actual.first.id, ref.first.id);
    expect(actual.first.name, ref.first.name);
  });
  test('copy with', () {
    final ref = [
      TagModel(id: 1, name: 'kiyomizudera'),
      TagModel(id: 2, name: 'kinkakuji')
    ];
    final actual = ref.first.copyWith(
      id: ref.first.id,
      name: ref.first.name,
    );

    expect(actual.id, ref.first.id);
    expect(actual.name, ref.first.name);
  });

  test('to json', () {
    final ref = {
      'id': 1,
      'name': 'kiyomizudera',
    };
    final actual = TagModel(
      id: 1,
      name: 'kiyomizudera',
    ).toJson();

    expect(actual, ref);
  });

  test('to string', () {
    const int id = 1;
    const String name = 'kiyomizudera';

    const ref = 'TagModel('
        'id: $id, '
        'name: $name'
        ')';

    final actual = TagModel(
      id: 1,
      name: 'kiyomizudera',
    ).toString();

    expect(actual, ref);
  });
}
