import 'package:showroom/core/domain/entities/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:showroom/core/data/datasources/assets_datasource.dart';
import 'package:showroom/features/products/domain/entities/product.dart';
import 'package:showroom/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryAssetJson extends ProductRepository {
  final AssetsDatasource _assetsDatasource;

  ProductRepositoryAssetJson({
    required AssetsDatasource assetsDatasource,
  }) : _assetsDatasource = assetsDatasource;

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await _assetsDatasource.jsonProducst();
      return products;
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getCollection(String id) async {
    try {
      final products = await _assetsDatasource.jsonProducst();
      var product = products.getOrElse(() => List<Product>.empty()).firstWhere(
            (element) => element.id == id,
            orElse: () => Product(
              id: "",
              name: "",
              description: "",
              variants: [],
            ),
          );
      return Right(product);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
