import 'package:meta/meta.dart';
import 'package:showroom/features/main/data/datasources/assets_datasource.dart';
import 'package:showroom/features/main/data/datasources/nfc_datasource.dart';
import 'package:showroom/features/main/domain/entities/product.dart';
import 'package:showroom/core/domain/entities/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:showroom/features/main/domain/repositories/product_repository.dart';

class ProductRepositoryAssetJson extends ProductRepository {
  final AssetsDatasource _assetsDatasource;
  final NfcDatasource _nfcDatasource;

  ProductRepositoryAssetJson({
    @required AssetsDatasource assetsDatasource,
    @required NfcDatasource nfcDatasource,
  })  : assert(assetsDatasource != null),
        assert(nfcDatasource != null),
        _nfcDatasource = nfcDatasource,
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

  @override
  Future<Either<Failure, String>> getClientId() async {
    try {
      return _nfcDatasource.readCard();
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
