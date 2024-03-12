import 'package:aqua_assignment/core/resources/data_state.dart';
import 'package:aqua_assignment/core/usecase/usecase.dart';
import 'package:aqua_assignment/features/home/domain/entity/product_entity.dart';
import 'package:aqua_assignment/features/home/domain/repositry/product_repositry.dart';

class GetProductsUseCase
    implements UseCase<DataState<List<ProductEntity>>, void> {
  final ProductRepositry _productRepositry;
  GetProductsUseCase(this._productRepositry);

  @override
  Future<DataState<List<ProductEntity>>> call({void params}) {
    // TODO: implement call
    return _productRepositry.getProducts();
  }
}
