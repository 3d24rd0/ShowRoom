import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:showroom/core/domain/entities/usecase.dart';
import 'package:showroom/features/panel/domain/entities/collection.dart';
import 'package:showroom/features/products/domain/entities/product.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';
import 'dart:developer' as developer;

import 'package:showroom/features/products/domain/usecases/get_products_usecase.dart';

part 'multitouch_event.dart';
part 'multitouch_state.dart';
class MultitouchBloc extends Bloc<MultitouchEvent, MultitouchState> {
  final GetProductsUsecase getProductsUsecase;
  
  MultitouchBloc(this.getProductsUsecase) : super(MultitouchInitial());
@override
  Stream<MultitouchState> mapEventToState(
    MultitouchEvent event,
  ) async* {
    try {
      yield* event.applyAsync( state,this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'MultitouchBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
