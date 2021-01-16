part of 'main_bloc.dart';

@immutable
abstract class MainEvent {
  Stream<MainState> applyAsync({MainState currentState, MainBloc bloc});
}

class LoadEvent extends MainEvent {
  @override
  Stream<MainState> applyAsync({MainState currentState, MainBloc bloc}) async* {
    bloc.add(LoadProducts());
    yield InitializedState(
      products: currentState.products,
      selectedProduct: currentState.selectedProduct,
      selectedVariant: currentState.selectedVariant,
    );
  }
}

class LoadProducts extends MainEvent {
  @override
  Stream<MainState> applyAsync({MainState currentState, MainBloc bloc}) async* {
    final products = await bloc.getProductsUsecase(NoParams());
    products.fold(
        (l) => Future.delayed(const Duration(seconds: 2), () {
              bloc.add(LoadProducts());
            }),
        (r) => bloc.add(SetProducts(r)));
  }
}

class SetProducts extends MainEvent {
  final List<Product> products;

  SetProducts(this.products);

  @override
  Stream<MainState> applyAsync({MainState currentState, MainBloc bloc}) async* {
    if (products.isNotEmpty) {
      yield currentState.copyWith(
        products: products,
        selectedProduct: products.first,
        selectedVariant: products.first.variants.first,
      );
    } else {
      print("No get  Products");
    }
  }
}

class SetCurrentProduct extends MainEvent {
  final Product product;

  SetCurrentProduct(this.product);

  @override
  Stream<MainState> applyAsync({MainState currentState, MainBloc bloc}) async* {
    if (product != null) {
      yield currentState.copyWith(selectedProduct: product);
    }
  }
}

class SetCurrentProductVariant extends MainEvent {
  final Variant variant;

  SetCurrentProductVariant(this.variant);

  @override
  Stream<MainState> applyAsync({MainState currentState, MainBloc bloc}) async* {
    if (variant != null) {
      yield currentState.copyWith(selectedVariant: variant);
    }
  }
}
