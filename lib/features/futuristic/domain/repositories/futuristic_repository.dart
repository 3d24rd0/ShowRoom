import 'package:dartz/dartz.dart';
import 'package:showroom/core/domain/entities/failures.dart';
import 'package:showroom/features/futuristic/domain/entities/material_list.dart';

abstract class FuturisticRepository {
  Future<Either<Failure, MaterialList>> getMaterials();
}
