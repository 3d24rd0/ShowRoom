part of 'product_bloc.dart';

@immutable
abstract class ProductState {
  final List<Product> products;
  final Product selectedProduct;
  final Variant selectedVariant;
  final String clientId;
  final String message;

  ProductState({
    @required this.products,
    @required this.selectedProduct,
    @required this.selectedVariant,
    @required this.clientId,
    @required this.message,
  });

  copyWith({
    List<Product> products,
    Product selectedProduct,
    Variant selectedVariant,
    String clientId,
    String message,
  });
}

class UninitializedState extends ProductState {
  UninitializedState()
      : super(
          products: null,
          selectedProduct: null,
          selectedVariant: null,
          clientId: "",
          message: "",
        );

  UninitializedState.withData({
    @required List<Product> products,
    @required Product selectedProduct,
    @required Variant selectedVariant,
    @required String clientId,
    @required String message,
  }) : super(
          products: products,
          selectedProduct: selectedProduct,
          selectedVariant: selectedVariant,
          clientId: clientId,
          message: message,
        );

  @override
  copyWith({
    List<Product> products,
    Product selectedProduct,
    Variant selectedVariant,
    String clientId,
    String message,
  }) =>
      UninitializedState.withData(
        products: products ?? this.products,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        selectedVariant: selectedVariant ?? this.selectedVariant,
        clientId: clientId ?? this.clientId,
        message: message ?? this.message,
      );
}

class InitializedState extends ProductState {
  InitializedState({
    @required List<Product> products,
    @required Product selectedProduct,
    @required Variant selectedVariant,
    @required String clientId,
    @required String message,
  }) : super(
          products: products,
          selectedProduct: selectedProduct,
          selectedVariant: selectedVariant,
          clientId: clientId,
          message: message,
        );

  @override
  copyWith({
    List<Product> products,
    Product selectedProduct,
    Variant selectedVariant,
    String clientId,
    String message,
  }) =>
      InitializedState(
        products: products ?? this.products,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        selectedVariant: selectedVariant ?? this.selectedVariant,
        clientId: clientId ?? this.clientId,
        message: message ?? this.message,
      );
}
