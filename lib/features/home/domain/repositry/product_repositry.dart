import 'package:aqua_assignment/core/resources/data_state.dart';
import 'package:aqua_assignment/features/home/data/models/product_model.dart';

abstract class ProductRepositry {
  Future<DataState<List<ProductModel>>> getProducts();
}
