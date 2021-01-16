import 'package:meta/meta.dart';
import 'package:showroom/features/main/data/datasources/assets_datasource.dart';
import 'package:showroom/features/main/domain/entities/product.dart';
import 'package:showroom/core/domain/entities/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:showroom/features/main/domain/repositories/product_repository.dart';

class ProductRepositoryAssetJson extends ProductRepository {
  final AssetsDatasource _assetsDatasource;

  ProductRepositoryAssetJson({
    @required AssetsDatasource assetsDatasource,
  })  : assert(assetsDatasource != null),
        _assetsDatasource = assetsDatasource;
  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await _assetsDatasource.jsonProducst();
      return products;
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
