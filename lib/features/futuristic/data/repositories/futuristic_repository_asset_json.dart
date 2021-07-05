import 'package:showroom/core/domain/entities/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:showroom/core/data/datasources/assets_datasource.dart';
import 'package:showroom/features/futuristic/domain/entities/material_list.dart';
import 'package:showroom/features/futuristic/domain/repositories/futuristic_repository.dart';

class FuturisticRepositoryAssetJson extends FuturisticRepository {
  final AssetsDatasource _assetsDatasource;

  FuturisticRepositoryAssetJson({
    required AssetsDatasource assetsDatasource,
  }) : _assetsDatasource = assetsDatasource;

  @override
  Future<Either<Failure, MaterialList>> getMaterials() async {
    try {
      final tv = await _assetsDatasource.jsonTv();
      return tv;
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
