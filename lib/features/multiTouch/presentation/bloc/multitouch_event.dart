part of 'multitouch_bloc.dart';

@immutable
abstract class MultitouchEvent {
  Stream<MultitouchState> applyAsync(
      MultitouchState currentState, MultitouchBloc bloc);
}

class LoadEvent extends MultitouchEvent {
  @override
  applyAsync(currentState, bloc) async* {
    var eProducts = await bloc.getProductsUsecase(NoParams());
    var products = eProducts.getOrElse(() => []);
    var product = products.first;
    yield currentState.copyWith(
        products: products,
        product: product,
        variant: product.variants?.first ?? currentState.variant);
  }
}

class SetCurrentProduct extends MultitouchEvent {
  final Product product;

  SetCurrentProduct(this.product);
  @override
  applyAsync(currentState, bloc) async* {
    yield currentState.copyWith(
        product: product,
        variant: product.variants?.first ?? currentState.variant);
  }
}

class SetCurrentProductVariantEvent extends MultitouchEvent {
  final Variant variant;

  SetCurrentProductVariantEvent(this.variant);
  @override
  applyAsync(currentState, bloc) async* {
    yield currentState.copyWith(variant: variant);
  }
}

class AddCollectionVariantEvent extends MultitouchEvent {
  @override
  applyAsync(currentState, bloc) async* {
    yield currentState.copyWith(
      collections: currentState.collections
        ..add(
          Collection(
            name: currentState.product.name,
            variantName: currentState.variant.name,
          ),
        ),
    );
  }
}

class SalirEvent extends MultitouchEvent {
  @override
  applyAsync(currentState, bloc) async* {
    yield currentState.copyWith(collections: []);
  }
}

class EnviarEvent extends MultitouchEvent {
  @override
  applyAsync(currentState, bloc) async* {
    yield currentState.copyWith(collections: []);
  }
}
