part of 'panel_bloc.dart';

@immutable
abstract class PanelState {
  final String? panelID;
  final CollectionPanel? collectionPanel;

  final Product? selectedProduct;
  final Variant? selectedVariant;

  PanelState({
    @required this.panelID,
    @required this.collectionPanel,
    @required this.selectedProduct,
    @required this.selectedVariant,
  });

  PanelState copyWith({
    String panelID,
    CollectionPanel collectionPanel,
    Product? selectedProduct,
    Variant? selectedVariant,
  });
}

class UninitializedState extends PanelState {
  UninitializedState()
      : super(
          panelID: null,
          collectionPanel: null,
          selectedProduct: null,
          selectedVariant: null,
        );

  UninitializedState.withData({
    @required String? panelID,
    @required CollectionPanel? collectionPanel,
    @required Product? selectedProduct,
    @required Variant? selectedVariant,
  }) : super(
          panelID: panelID,
          collectionPanel: collectionPanel,
          selectedProduct: selectedProduct,
          selectedVariant: selectedVariant,
        );

  @override
  UninitializedState copyWith({
    String? panelID,
    CollectionPanel? collectionPanel,
    Product? selectedProduct,
    Variant? selectedVariant,
  }) =>
      UninitializedState.withData(
        panelID: panelID ?? this.panelID,
        collectionPanel: collectionPanel ?? this.collectionPanel,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        selectedVariant: selectedVariant ?? this.selectedVariant,
      );
}

class InitializedState extends PanelState {
  InitializedState({
    @required String? panelID,
    @required CollectionPanel? collectionPanel,
    @required Product? selectedProduct,
    @required Variant? selectedVariant,
  }) : super(
          panelID: panelID,
          collectionPanel: collectionPanel,
          selectedProduct: selectedProduct,
          selectedVariant: selectedVariant,
        );

  @override
  InitializedState copyWith({
    String? panelID,
    CollectionPanel? collectionPanel,
    Product? selectedProduct,
    Variant? selectedVariant,
  }) =>
      InitializedState(
        panelID: panelID ?? this.panelID,
        collectionPanel: collectionPanel ?? this.collectionPanel,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        selectedVariant: selectedVariant ?? this.selectedVariant,
      );
}
