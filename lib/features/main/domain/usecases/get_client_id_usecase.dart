import 'package:meta/meta.dart';
import 'package:showroom/core/domain/entities/usecase.dart';
import 'package:showroom/features/main/domain/repositories/product_repository.dart';

class GetClientIdUsecase implements UseCase<String, NoParams> {
  final ProductRepository _repository;
  GetClientIdUsecase({@required ProductRepository repository})
      : assert(repository != null),
        _repository = repository;

  @override
  call(search) async {
    return _repository.getClientId();
  }
}
