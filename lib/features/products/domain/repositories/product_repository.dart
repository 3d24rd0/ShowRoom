import 'package:dartz/dartz.dart';
import 'package:showroom/core/domain/entities/failures.dart';
import 'package:showroom/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}
