import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:process_loop/process_loop.dart';
import 'package:showroom/core/domain/entities/usecase.dart';
import 'package:showroom/features/products/domain/entities/product.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';
import 'dart:developer' as developer;

import 'package:showroom/features/products/domain/usecases/get_products_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUsecase getProductsUsecase;

  StreamSubscription _nfcSubscription;

  ProductBloc(
    this.getProductsUsecase,
  ) : super(UninitializedState());

  @override
  close() async {
    _nfcSubscription?.cancel();
    super.close();
  }

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
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
