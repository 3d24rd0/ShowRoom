import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:showroom/core/domain/entities/usecase.dart';
import 'package:showroom/features/futuristic/domain/entities/material_list.dart';
import 'dart:developer' as developer;

import 'package:showroom/features/futuristic/domain/entities/materials.dart';
import 'package:showroom/features/futuristic/domain/usecases/get_materials_usecase.dart';
import 'package:showroom/features/products/domain/entities/product.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';
import 'package:showroom/features/products/domain/usecases/get_products_usecase.dart';

part 'futuristic_event.dart';
part 'futuristic_state.dart';

class FuturisticBloc extends Bloc<FuturisticEvent, FuturisticState> {
  final GetMaterialsUsecase getMaterialsUsecase;
  final GetProductsUsecase getProductsUsecase;

  FuturisticBloc(
    this.getMaterialsUsecase,
    this.getProductsUsecase,
  ) : super(UninitializedState());

  @override
  Stream<FuturisticState> mapEventToState(
    FuturisticEvent event,
  ) async* {
    try {
      yield* event.applyAsync(state, this);
    } catch (_, stackTrace) {
      developer.log(
        '$_',
        name: 'FuturisticBloc',
        error: _,
        stackTrace: stackTrace,
      );
      yield state;
    }
  }
}
