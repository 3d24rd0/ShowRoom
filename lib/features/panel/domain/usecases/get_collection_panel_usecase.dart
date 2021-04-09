import 'package:showroom/core/domain/entities/usecase.dart';
import 'package:showroom/features/panel/domain/entities/collection_panel.dart';
import 'package:showroom/features/panel/domain/repositories/panel_repository.dart';

class GetCollectionPanelUsecase implements UseCase<CollectionPanel, String> {
  final PanelRepository _repository;
  GetCollectionPanelUsecase({required PanelRepository repository})
      : _repository = repository;

  @override
  call(id) async {
    return _repository.getCollectionPanel(id);
  }
}
