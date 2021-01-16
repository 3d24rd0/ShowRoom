part of 'main_bloc.dart';

@immutable
abstract class MainState {
  final List<Product> products;
  final Product selectedProduct;
  final Variant selectedVariant;
  final String clientId;

  MainState({
    @required this.products,
    @required this.selectedProduct,
    @required this.selectedVariant,
    @required this.clientId,
  });

  copyWith({
    List<Product> products,
    Product selectedProduct,
    Variant selectedVariant,
    String clientId,
  });
}

class UninitializedState extends MainState {
  UninitializedState()
      : super(
          products: null,
          selectedProduct: null,
          selectedVariant: null,
          clientId: "",
        );

  UninitializedState.withData({
    @required List<Product> products,
    @required Product selectedProduct,
    @required Variant selectedVariant,
    @required String clientId,
  }) : super(
          products: products,
          selectedProduct: selectedProduct,
          selectedVariant: selectedVariant,
          clientId: clientId,
        );

  @override
  copyWith({
    List<Product> products,
    Product selectedProduct,
    Variant selectedVariant,
    String clientId,
  }) =>
      UninitializedState.withData(
        products: products ?? this.products,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        selectedVariant: selectedVariant ?? this.selectedVariant,
        clientId: clientId ?? this.clientId,
      );
}

class InitializedState extends MainState {
  InitializedState({
    @required List<Product> products,
    @required Product selectedProduct,
    @required Variant selectedVariant,
    @required String clientId,
  }) : super(
          products: products,
          selectedProduct: selectedProduct,
          selectedVariant: selectedVariant,
          clientId: clientId,
        );

  @override
  copyWith({
    List<Product> products,
    Product selectedProduct,
    Variant selectedVariant,
    String clientId,
  }) =>
      InitializedState(
        products: products ?? this.products,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        selectedVariant: selectedVariant ?? this.selectedVariant,
        clientId: clientId ?? this.clientId,
      );
}
