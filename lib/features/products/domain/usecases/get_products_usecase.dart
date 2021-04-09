import 'package:showroom/core/domain/entities/usecase.dart';
import 'package:showroom/features/products/domain/entities/product.dart';
import 'package:showroom/features/products/domain/repositories/product_repository.dart';

class GetProductsUsecase implements UseCase<List<Product>, NoParams> {
  final ProductRepository _repository;
  GetProductsUsecase({required ProductRepository repository})
      : _repository = repository;

  @override
  call(search) async {
    return _repository.getProducts();
  }
}
