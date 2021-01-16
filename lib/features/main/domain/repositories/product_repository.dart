import 'package:dartz/dartz.dart';
import 'package:showroom/core/domain/entities/failures.dart';
import 'package:showroom/features/main/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}
