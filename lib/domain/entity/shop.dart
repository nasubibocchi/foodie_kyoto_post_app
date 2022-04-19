class Shop {
  final String name;
  final String shopId;
  final dynamic position;
  final String comment;
  final List<String> images;
  final List<int> tags;

  Shop({
    required this.name,
    required this.shopId,
    required this.position,
    required this.comment,
    required this.images,
    required this.tags,
  });
}
