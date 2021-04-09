part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {
  Stream<ProductState> applyAsync(
      {ProductState? currentState, ProductBloc? bloc});
}

class LoadEvent extends ProductEvent {
  @override
  Stream<ProductState> applyAsync({currentState, bloc}) async* {
    bloc?.add(LoadProducts());

    // final nfcProcess = ProgressLoop(
    //   executable: "readNFC",
    //   arguments: null,
    //   loop: Duration(seconds: 2),
    // );
    // bloc._nfcSubscription = nfcProcess.stdout.listen((event) {
    //   bloc.add(SetPhysicalClient(event));
    // });
    // nfcProcess.start();

    Future.delayed(const Duration(seconds: 2), () {
      bloc?.add(LoadDelayedEvent());
    });
  }
}

class LoadDelayedEvent extends ProductEvent {
  @override
  Stream<ProductState> applyAsync({currentState, bloc}) async* {
    yield InitializedState(
      products: currentState?.products,
      selectedProduct: currentState?.selectedProduct,
      selectedVariant: currentState?.selectedVariant,
      clientId: currentState?.clientId,
      message: currentState?.message,
    );
  }
}

class LoadProducts extends ProductEvent {
  @override
  Stream<ProductState> applyAsync({currentState, bloc}) async* {
    final products = await bloc?.getProductsUsecase(NoParams());
    products?.fold(
        (l) => Future.delayed(const Duration(seconds: 2), () {
              bloc?.add(LoadProducts());
            }),
        (r) => bloc?.add(SetProducts(r)));
  }
}

class SetProducts extends ProductEvent {
  final List<Product>? products;

  SetProducts(this.products);

  @override
  Stream<ProductState> applyAsync({currentState, bloc}) async* {
    if (products?.isNotEmpty ?? false) {
      ProductState? newState = currentState?.copyWith(
        products: products,
        selectedProduct: products?.first,
        selectedVariant: products?.first.variants?.first,
      );
      if (newState != null) {
        yield newState;
      }
    } else {
      print("No get  Products");
    }
  }
}

class SetCurrentProduct extends ProductEvent {
  final Product? product;

  SetCurrentProduct(this.product);

  @override
  Stream<ProductState> applyAsync({currentState, bloc}) async* {
    if (product != null) {
      ProductState? newState = currentState?.copyWith(
          selectedProduct: product, selectedVariant: product?.variants?.first);
      if (newState != null) {
        yield newState;
      }
    }
  }
}

class SetCurrentProductVariant extends ProductEvent {
  final Variant? variant;

  SetCurrentProductVariant(this.variant);

  @override
  Stream<ProductState> applyAsync({currentState, bloc}) async* {
    if (variant != null) {
      ProductState? newState = currentState?.copyWith(selectedVariant: variant);
      if (newState != null) {
        yield newState;
      }
    }
  }
}

class SetPhysicalClient extends ProductEvent {
  final String clientId;

  SetPhysicalClient(this.clientId);

  @override
  Stream<ProductState> applyAsync({currentState, bloc}) async* {
    final message = (clientId +
            " - " +
            (currentState?.selectedProduct?.name ?? " ") +
            " - " +
            (currentState?.selectedVariant?.name ?? " "))
        .replaceAll(RegExp(r'\n'), "");
    ProductState? newState =
        currentState?.copyWith(clientId: clientId, message: message);
    if (newState != null) {
      yield newState;
    }
  }
}
