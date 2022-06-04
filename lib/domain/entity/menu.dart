class Menu {
  Menu(
      {required this.name,
      required this.shopId,
      required this.images,
      required this.foodTags,
      required this.price,
      required this.review});

  final String name;
  final String shopId;
  final List<String> images;
  final List<int> foodTags;
  final int price;
  final String review;
}
