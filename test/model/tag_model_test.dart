import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/tag_model.dart';

void main() {
  final data = [
    {
      'id': 1,
      'name': 'kiyomizudera',
      'shop_id_list': ['shop_1', 'shop_2'],
    },
    {
      'id': 2,
      'name': 'kinkakuji',
      'shop_id_list': [],
    }
  ];

  test('from json', () {
    final ref = [
      TagModel(id: 1, name: 'kiyomizudera', shopIdList: ['shop_1', 'shop_2']),
      TagModel(id: 2, name: 'kinkakuji', shopIdList: [])
    ];
    final actual = data.map((e) => TagModel.fromJson(e)).toList();

    expect(actual.first.id, ref.first.id);
    expect(actual.first.name, ref.first.name);
    expect(actual.first.shopIdList, ref.first.shopIdList);
  });
  test('copy with', () {
    final ref = [
      TagModel(id: 1, name: 'kiyomizudera', shopIdList: ['shop_1', 'shop_2']),
      TagModel(id: 2, name: 'kinkakuji', shopIdList: [])
    ];
    final actual = ref.first.copyWith(
      id: ref.first.id,
      name: ref.first.name,
      shopIdList: ref.first.shopIdList,
    );

    expect(actual.id, ref.first.id);
    expect(actual.name, ref.first.name);
    expect(actual.shopIdList, ref.first.shopIdList);
  });

  test('to json', () {
    final ref = {
      'id': 1,
      'name': 'kiyomizudera',
      'shop_id_list': ['shop_1', 'shop_2'],
    };
    final actual = TagModel(
      id: 1,
      name: 'kiyomizudera',
      shopIdList: ['shop_1', 'shop_2'],
    ).toJson();

    expect(actual, ref);
  });

  test('to string', () {
    const int id = 1;
    const String name = 'kiyomizudera';
    const List<String> shopIdList = ['shop_1', 'shop_2'];

    final ref = 'TagModel('
        'id: $id, '
        'name: $name, '
        'shopIdList: $shopIdList'
        ')';

    final actual = TagModel(
      id: 1,
      name: 'kiyomizudera',
      shopIdList: ['shop_1', 'shop_2'],
    ).toString();

    expect(actual, ref);
  });
}
