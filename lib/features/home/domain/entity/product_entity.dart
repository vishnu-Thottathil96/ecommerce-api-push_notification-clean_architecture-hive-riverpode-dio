class ProductEntity {
  final int id;
  final String title;
  final String description;
  final num price;
  final num discountPersentage;
  final num rating;
  final num stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPersentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });
}
