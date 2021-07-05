part of 'futuristic_bloc.dart';

@immutable
abstract class FuturisticState {
  final List<Materials>? materiales;
  final List<String>? selectedProducsId;
  final List<Product>? products;
  final List<Variant>? variants;

  FuturisticState({
    required this.materiales,
    required this.selectedProducsId,
    required this.products,
    required this.variants,
  });

  FuturisticState copyWith({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
  });
}

class UninitializedState extends FuturisticState {
  UninitializedState()
      : super(
          materiales: null,
          selectedProducsId: null,
          products: null,
          variants:null,
        );

  UninitializedState.withData({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
  }) : super(
          materiales: materiales,
          selectedProducsId: selectedProducsId,
          products: products,
          variants: variants,
        );

  @override
  copyWith({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
  }) =>
      UninitializedState.withData(
        materiales: materiales ?? this.materiales,
        selectedProducsId: selectedProducsId ?? this.selectedProducsId,
        products: products ?? this.products,
        variants: variants ?? this.variants,
      );
}

class InitializedState extends FuturisticState {
  InitializedState({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
  }) : super(
          materiales: materiales,
          selectedProducsId: selectedProducsId,
          products: products,
          variants: variants,
        );

  @override
  copyWith({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
  }) =>
      InitializedState(
        materiales: materiales ?? this.materiales,
        selectedProducsId: selectedProducsId ?? this.selectedProducsId,
        products: products ?? this.products,
        variants: variants ?? this.variants,
      );
}
