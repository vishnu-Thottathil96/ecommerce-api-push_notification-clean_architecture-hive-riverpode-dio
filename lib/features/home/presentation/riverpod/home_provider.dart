import 'package:aqua_assignment/core/resources/data_state.dart';
import 'package:aqua_assignment/features/home/data/data_sources/remote/api_service.dart';
import 'package:aqua_assignment/features/home/data/repositry_impl/product_repositry_impl.dart';
import 'package:aqua_assignment/features/home/domain/entity/product_entity.dart';
import 'package:aqua_assignment/features/home/domain/usecases/get_product_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsProvider = FutureProvider<List<ProductEntity>>((ref) async {
  final instance = GetProductsUseCase(ProductRepositryImpl(ApiService(Dio())));
  final dataState = await instance.call();
  if (dataState is DataSuccess) {
    return dataState.data!;
  } else {
    return [];
  }
});
