part of 'futuristic_bloc.dart';

@immutable
abstract class FuturisticState {
  final List<Materials>? materiales;
  final List<String>? selectedProducsId;
  final List<Product>? products;
  final List<Variant>? variants;
  final bool? showNotes;
  final DrawController controller = DrawController();

  FuturisticState({
    required this.materiales,
    required this.selectedProducsId,
    required this.products,
    required this.variants,
    required this.showNotes,
  });

  FuturisticState copyWith({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
    bool? showNotes,
  });
}

class UninitializedState extends FuturisticState {
  UninitializedState()
      : super(
          materiales: null,
          selectedProducsId: null,
          products: null,
          variants: null,
          showNotes: false,
        );

  UninitializedState.withData({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
    bool? showNotes,
  }) : super(
          materiales: materiales,
          selectedProducsId: selectedProducsId,
          products: products,
          variants: variants,
          showNotes: showNotes,
        );

  @override
  copyWith({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
    bool? showNotes,
  }) =>
      UninitializedState.withData(
        materiales: materiales ?? this.materiales,
        selectedProducsId: selectedProducsId ?? this.selectedProducsId,
        products: products ?? this.products,
        variants: variants ?? this.variants,
        showNotes: showNotes ?? this.showNotes,
      );
}

class InitializedState extends FuturisticState {
  InitializedState({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
    bool? showNotes,
  }) : super(
          materiales: materiales,
          selectedProducsId: selectedProducsId,
          products: products,
          variants: variants,
          showNotes: showNotes,
        );

  @override
  copyWith({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
    bool? showNotes,
  }) =>
      InitializedState(
        materiales: materiales ?? this.materiales,
        selectedProducsId: selectedProducsId ?? this.selectedProducsId,
        products: products ?? this.products,
        variants: variants ?? this.variants,
        showNotes: showNotes ?? this.showNotes,
      );
}
