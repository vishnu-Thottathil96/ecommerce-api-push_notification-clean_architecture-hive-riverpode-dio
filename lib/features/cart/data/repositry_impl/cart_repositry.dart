// import 'package:dio/dio.dart';

// class CartElement {
//   CartElement({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.discountPercentage,
//     required this.rating,
//     required this.stock,
//     required this.brand,
//     required this.category,
//     required this.thumbnail,
//     required this.images,
//   });

//   final int? id;
//   final String? title;
//   final String? description;
//   final int? price;
//   final double? discountPercentage;
//   final double? rating;
//   final int? stock;
//   final String? brand;
//   final String? category;
//   final String? thumbnail;
//   final List<String> images;

//   factory CartElement.fromJson(Map<String, dynamic> json) {
//     return CartElement(
//       id: json["id"],
//       title: json["title"],
//       description: json["description"],
//       price: json["price"],
//       discountPercentage: json["discountPercentage"],
//       rating: json["rating"],
//       stock: json["stock"],
//       brand: json["brand"],
//       category: json["category"],
//       thumbnail: json["thumbnail"],
//       images: json["images"] == null
//           ? []
//           : List<String>.from(json["images"]!.map((x) => x)),
//     );
//   }
// }

// class ApiService {
//   final Dio _dio;

//   ApiService() : _dio = Dio();

//   Future<Response> get(String path) async {
//     try {
//       final response = await _dio.get(path);
//       return response;
//     } on DioException catch (e) {
//       // Handle Dio errors here
//       throw Exception(e.message);
//     }
//   }
// }

// class CartOperations {
//   static Set<int> cartIdList = {};

//   final ApiService _apiService = ApiService();

//   void addCartId(int id) {
//     cartIdList.add(id);
//   }

//   Future<List<CartElement>> fetchCartProducts() async {
//     List<CartElement> cartProducts = [];

//     for (int id in cartIdList) {
//       try {
//         final response =
//             await _apiService.get('https://dummyjson.com/products/$id');
//         final productData = CartElement.fromJson(response.data);
//         cartProducts.add(productData);
//       } catch (e) {
//         print('Error fetching product $id: $e');
//       }
//     }

//     return cartProducts;
//   }
// }
