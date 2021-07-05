import 'package:showroom/core/domain/entities/usecase.dart';
import 'package:showroom/features/futuristic/domain/entities/material_list.dart';
import 'package:showroom/features/futuristic/domain/repositories/futuristic_repository.dart';

class GetMaterialsUsecase implements UseCase<MaterialList, NoParams> {
  final FuturisticRepository _repository;
  GetMaterialsUsecase({required FuturisticRepository repository})
      : _repository = repository;

  @override
  call(id) async {
    return _repository.getMaterials();
  }
}
