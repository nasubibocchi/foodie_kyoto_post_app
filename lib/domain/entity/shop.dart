class Shop {
  final String name;
  final String shopId;
  final double latitude;
  final double longitude;
  final String comment;
  final List<String> images;
  final List<int> tags;
  final String postUser;

  Shop({
    required this.name,
    required this.shopId,
    required this.latitude,
    required this.longitude,
    required this.comment,
    required this.images,
    required this.tags,
    required this.postUser,
  });
}
