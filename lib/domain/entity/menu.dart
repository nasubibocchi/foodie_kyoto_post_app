class Menu {
  Menu(
      {required this.name,
      required this.shopId,
      required this.images,
      required this.movies,
      required this.foodTags,
      required this.price,
      required this.review,
      required this.enReview,
      required this.postUser});

  final String name;
  final String shopId;
  final List<String> images;
  final List<String> movies;
  final List<int> foodTags;
  final int price;
  final String review;
  final String enReview;
  final String postUser;
}
