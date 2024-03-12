import 'package:aqua_assignment/core/resources/data_state.dart';
import 'package:aqua_assignment/features/home/data/data_sources/remote/api_service.dart';
import 'package:aqua_assignment/features/home/data/models/product_model.dart';
import 'package:aqua_assignment/features/home/domain/repositry/product_repositry.dart';
import 'package:dio/dio.dart';

class ProductRepositryImpl implements ProductRepositry {
  final ApiService _apiService;
  ProductRepositryImpl(this._apiService);
  @override
  Future<DataState<List<ProductModel>>> getProducts() async {
    try {
      final response = await _apiService.fetchProducts();
      if (response.statusCode == 200) {
        final data = response.data['products'] as List;
        final products = data.map((e) => ProductModel.fromJson(e)).toList();
        return DataSuccess(products);
      } else {
        return DataFailed(DioException(
            requestOptions: response.requestOptions,
            error: response.statusMessage));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
    // throw UnimplementedError();
  }
}
