part of 'futuristic_bloc.dart';

@immutable
abstract class FuturisticState {
  final List<Materials>? materiales;
  final List<String>? selectedProducsId;
  final List<Product>? products;
  final List<Variant>? variants;
  final bool? showNotes;
  final String? selectedMaterial;

  FuturisticState({
    required this.materiales,
    required this.selectedProducsId,
    required this.products,
    required this.variants,
    required this.showNotes,
    required this.selectedMaterial,
  });

  FuturisticState copyWith({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
    bool? showNotes,
    String? selectedMaterial,
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
          selectedMaterial: null,
        );

  UninitializedState.withData({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
    bool? showNotes,
    String? selectedMaterial,
  }) : super(
          materiales: materiales,
          selectedProducsId: selectedProducsId,
          products: products,
          variants: variants,
          showNotes: showNotes,
          selectedMaterial: selectedMaterial,
        );

  @override
  copyWith({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
    bool? showNotes,
    String? selectedMaterial,
  }) =>
      UninitializedState.withData(
        materiales: materiales ?? this.materiales,
        selectedProducsId: selectedProducsId ?? this.selectedProducsId,
        products: products ?? this.products,
        variants: variants ?? this.variants,
        showNotes: showNotes ?? this.showNotes,
        selectedMaterial: selectedMaterial ?? this.selectedMaterial,
      );
}

class InitializedState extends FuturisticState {
  InitializedState({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
    bool? showNotes,
    String? selectedMaterial,
  }) : super(
          materiales: materiales,
          selectedProducsId: selectedProducsId,
          products: products,
          variants: variants,
          showNotes: showNotes,
          selectedMaterial: selectedMaterial,
        );

  @override
  copyWith({
    List<Materials>? materiales,
    List<String>? selectedProducsId,
    List<Product>? products,
    List<Variant>? variants,
    bool? showNotes,
    String? selectedMaterial,
  }) =>
      InitializedState(
        materiales: materiales ?? this.materiales,
        selectedProducsId: selectedProducsId ?? this.selectedProducsId,
        products: products ?? this.products,
        variants: variants ?? this.variants,
        showNotes: showNotes ?? this.showNotes,
        selectedMaterial: selectedMaterial ?? this.selectedMaterial,
      );
}
