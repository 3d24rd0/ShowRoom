import 'package:showroom/core/domain/entities/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:showroom/core/data/datasources/assets_datasource.dart';
import 'package:showroom/features/panel/domain/entities/collection_panel.dart';
import 'package:showroom/features/panel/domain/repositories/panel_repository.dart';

class PanelRepositoryAssetJson extends PanelRepository {
  final AssetsDatasource _assetsDatasource;

  PanelRepositoryAssetJson({
    required AssetsDatasource assetsDatasource,
  }) : _assetsDatasource = assetsDatasource;


  @override
  Future<Either<Failure, CollectionPanel>> getCollectionPanel(String panelID) async {
    try {
      final panel = await _assetsDatasource.jsonPanel(panelID);
      return panel;
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
