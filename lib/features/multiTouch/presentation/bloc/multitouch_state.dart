part of 'multitouch_bloc.dart';

@immutable
abstract class MultitouchState {
  final List<Product> products;
  final List<Collection> collections;
  final Product product;
  final Variant variant;

  MultitouchState({
    required this.products,
    required this.collections,
    required this.product,
    required this.variant,
  });

  MultitouchState copyWith({
    List<Product> products,
    List<Collection> collections,
    Product product,
    Variant variant,
  });
}

class MultitouchInitial extends MultitouchState {
  MultitouchInitial()
      : super(
          products: [],
          collections: [],
          variant: Variant(
              img: "", example: "notfound.jpeg", name: "", measures: []),
          product: Product(name: "", description: "", variants: []),
        );

  MultitouchInitial.withData({
    required List<Product> products,
    required List<Collection> collections,
    required Product product,
    required Variant variant,
  }) : super(
          products: products,
          collections: collections,
          product: product,
          variant: variant,
        );

  @override
  copyWith({
    List<Product>? products,
    List<Collection>? collections,
    Product? product,
    Variant? variant,
  }) =>
      MultitouchInitial.withData(
        products: products ?? this.products,
        collections: collections ?? this.collections,
        product: product ?? this.product,
        variant: variant ?? this.variant,
      );
}
