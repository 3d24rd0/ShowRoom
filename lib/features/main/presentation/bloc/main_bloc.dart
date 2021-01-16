import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:showroom/core/domain/entities/usecase.dart';
import 'package:showroom/features/main/domain/entities/product.dart';
import 'package:showroom/features/main/domain/entities/variant.dart';
import 'dart:developer' as developer;

import 'package:showroom/features/main/domain/usecases/get_products_usecase.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetProductsUsecase getProductsUsecase;

  MainBloc(this.getProductsUsecase) : super(UninitializedState());

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'CardFormBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
