part of 'main_bloc.dart';

@immutable
abstract class MainState {
  final List<Product> products;
  final Product selectedProduct;
  final Variant selectedVariant;

  MainState({
    @required this.products,
    @required this.selectedProduct,
    @required this.selectedVariant,
  });

  copyWith({
    List<Product> products,
    Product selectedProduct,
    Variant selectedVariant,
  });
}

class UninitializedState extends MainState {
  UninitializedState()
      : super(products: null, selectedProduct: null, selectedVariant: null);

  UninitializedState.withData(
      {@required List<Product> products,
      @required Product selectedProduct,
      @required Variant selectedVariant})
      : super(
          products: products,
          selectedProduct: selectedProduct,
          selectedVariant: selectedVariant,
        );

  @override
  copyWith({
    List<Product> products,
    Product selectedProduct,
    Variant selectedVariant,
  }) =>
      UninitializedState.withData(
        products: products ?? this.products,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        selectedVariant: selectedVariant ?? this.selectedVariant,
      );
}

class InitializedState extends MainState {
  InitializedState({
    @required List<Product> products,
    @required Product selectedProduct,
    @required Variant selectedVariant,
  }) : super(
          products: products,
          selectedProduct: selectedProduct,
          selectedVariant: selectedVariant,
        );

  @override
  copyWith({
    List<Product> products,
    Product selectedProduct,
    Variant selectedVariant,
  }) =>
      InitializedState(
        products: products ?? this.products,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        selectedVariant: selectedVariant ?? this.selectedVariant,
      );
}
