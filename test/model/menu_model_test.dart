import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/menu_model.dart';

void main() {
  final data = [
    {
      'menu_id': 'menu_id_1',
      'name': 'menu_name_1',
      'shop_id': 'shop_id_1',
      'images': ['image1', 'image2'],
      'movies': ['movie1', 'movie2'],
      'food_tags': [1, 2, 3],
      'price': 3000,
      'review': 'review1',
      'en_review': 'en_review1',
      'post_user': 'user1',
    },
  ];

  test('MenuModel.fromJson', () {
    final test = MenuModel.fromJson(data.first);

    final actual = MenuModel(
        menuId: 'menu_id_1',
        name: 'menu_name_1',
        shopId: 'shop_id_1',
        images: ['image1', 'image2'],
        movies: ['movie1', 'movie2'],
        foodTags: [1, 2],
        price: 3000,
        review: 'review1',
        enReview: 'en_review1',
        postUser: 'user1');

    expect(actual.name, test.name);
    expect(actual.shopId, test.shopId);
  });

  group('copyWith', () {
    test('copyWith = original', () {
      final original = MenuModel(
          menuId: 'menu_id_1',
          name: 'menu_name_1',
          shopId: 'shop_id_1',
          images: ['image1', 'image2'],
          movies: ['movie1', 'movie2'],
          foodTags: [1, 2],
          price: 3000,
          review: 'review1',
          enReview: 'en_review1',
          postUser: 'user1');

      final copyWith = original.copyWith(
          menuId: original.menuId,
          name: original.name,
          shopId: original.shopId,
          images: original.images,
          movies: original.movies,
          foodTags: original.foodTags,
          price: original.price,
          review: original.review,
          enReview: original.enReview,
          postUser: original.postUser);

      expect(copyWith.name, original.name);
      expect(copyWith.price, original.price);
    });

    test('copyWith != original', () {
      final original = MenuModel(
          menuId: 'menu_id_1',
          name: 'menu_name_1',
          shopId: 'shop_id_2',
          images: ['image1', 'image2'],
          movies: ['movie1', 'movie2'],
          foodTags: [1, 2],
          price: 5000,
          review: 'review2',
          enReview: 'en_review1',
          postUser: 'user1');
      final copyWith = original.copyWith(
          menuId: original.menuId,
          name: original.name,
          shopId: original.name,
          images: original.images,
          movies: original.movies,
          foodTags: original.foodTags,
          price: original.price,
          review: original.review,
          enReview: original.enReview,
          postUser: original.postUser);

      expect(copyWith.shopId, isNot(original.shopId));
    });
  });

  test('toJson()', () {
    final ref = {
      'menu_id': 'menu_id_1',
      'name': 'menu_name_1',
      'shop_id': 'shop_id_1',
      'images': ['image1', 'image2'],
      'movies': ['movie1', 'movie2'],
      'food_tags': [1, 2],
      'price': 3000,
      'review': 'review1',
      'en_review': 'en_review1',
      'post_user': 'user1',
    };

    final original = MenuModel(
        menuId: 'menu_id_1',
        name: 'menu_name_1',
        shopId: 'shop_id_1',
        images: ['image1', 'image2'],
        movies: ['movie1', 'movie2'],
        foodTags: [1, 2],
        price: 3000,
        review: 'review1',
        enReview: 'en_review1',
        postUser: 'user1');

    final json = original.toJson();
    expect(json, ref);
  });

  test('toString()', () {
    const ref = 'MenuModel('
        'menuId: menu_id_1, '
        'name: menu_name_1, '
        'shopId: shop_id_1, '
        'images: [image1, image2], '
        'movies: [movie1, movie2], '
        'foodTags: [1, 2], '
        'price: 3000, '
        'review: review1, '
        'enReview: en_review1, '
        'postUser: user1)';

    final original = MenuModel(
        menuId: 'menu_id_1',
        name: 'menu_name_1',
        shopId: 'shop_id_1',
        images: ['image1', 'image2'],
        movies: ['movie1', 'movie2'],
        foodTags: [1, 2],
        price: 3000,
        review: 'review1',
        enReview: 'en_review1',
        postUser: 'user1');

    final json = original.toString();
    expect(json, ref);
  });
}
