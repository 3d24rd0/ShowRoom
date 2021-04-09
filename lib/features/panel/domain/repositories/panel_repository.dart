import 'package:dartz/dartz.dart';
import 'package:showroom/core/domain/entities/failures.dart';
import 'package:showroom/features/panel/domain/entities/collection_panel.dart';

abstract class PanelRepository {
  Future<Either<Failure, CollectionPanel>> getCollectionPanel(String panelID);
}
