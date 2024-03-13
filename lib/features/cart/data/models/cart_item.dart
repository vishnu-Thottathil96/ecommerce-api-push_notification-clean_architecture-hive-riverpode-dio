import 'package:hive/hive.dart';
part 'cart_item.g.dart';

@HiveType(typeId: 0)
class CartElement {
  CartElement({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    this.count = 1,
  });
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final int? price;
  @HiveField(4)
  final double? discountPercentage;
  @HiveField(5)
  final double? rating;
  @HiveField(6)
  final int? stock;
  @HiveField(7)
  final String? brand;
  @HiveField(8)
  final String? category;
  @HiveField(9)
  final String? thumbnail;
  @HiveField(10)
  final List<String> images;
  @HiveField(11)
  int count;

  factory CartElement.fromJson(Map<String, dynamic> json) {
    return CartElement(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
      discountPercentage: json["discountPercentage"],
      rating: json["rating"],
      stock: json["stock"],
      brand: json["brand"],
      category: json["category"],
      thumbnail: json["thumbnail"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
    );
  }
}
