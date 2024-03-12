import 'package:aqua_assignment/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  ApiService(this._dio);
  Future<Response> fetchProducts() async {
    final String url = ApiConstants.productsUrl;
    final Response response = await _dio.get(url);
    return response;
  }
}
