import 'package:showroom/core/domain/entities/usecase.dart';
import 'package:showroom/features/products/domain/entities/product.dart';
import 'package:showroom/features/products/domain/repositories/product_repository.dart';

class GetCollectionUsecase implements UseCase<Product, String> {
  final ProductRepository _repository;
  GetCollectionUsecase({required ProductRepository repository})
      : _repository = repository;

  @override
  call(collection) async {
    return _repository.getCollection(collection);
  }
}

