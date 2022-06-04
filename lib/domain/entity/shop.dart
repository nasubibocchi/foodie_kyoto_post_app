class Shop {
  final String name;
  final String shopId;
  final double latitude;
  final double longitude;
  final String comment;
  final List<String> images;
  final List<int> serviceTags;
  final List<int> areaTags;
  final List<int> foodTags;
  final String postUser;
  final int price;

  Shop({
    required this.name,
    required this.shopId,
    required this.latitude,
    required this.longitude,
    required this.comment,
    required this.images,
    required this.serviceTags,
    required this.areaTags,
    required this.foodTags,
    required this.postUser,
    required this.price,
  });
}
