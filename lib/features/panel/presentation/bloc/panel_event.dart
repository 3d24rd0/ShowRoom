part of 'panel_bloc.dart';

@immutable
abstract class PanelEvent {
  Stream<PanelState> applyAsync( PanelState currentState,  PanelBloc bloc);
}

class LoadEvent extends PanelEvent {
  final String id;

  LoadEvent(this.id);

  @override
  Stream<PanelState> applyAsync(currentState, bloc) async* {
    var eCollectionPanel = await bloc.getCollectionPanelUsecase(id);
    CollectionPanel? collectionPanel = eCollectionPanel.getOrElse(
      () => CollectionPanel(
        leftCollection: List.empty(),
        rightCollection: List.empty(),
      ),
    );

    var first = collectionPanel.leftCollection.first;

    yield InitializedState(
      panelID: id,
      collectionPanel: collectionPanel,
      selectedProduct: null,
      selectedVariant: null,
    );

    bloc.add(
      SelectEvent(
        first ,
      ),
    );
  }
}

class SelectEvent extends PanelEvent {
  final Collection collection;

  SelectEvent(this.collection);

  @override
  Stream<PanelState> applyAsync(currentState, bloc) async* {
    var eProduct = await bloc.getCollectionUsecase(collection.productId ?? "");
    var product = eProduct.getOrElse(
      () => Product(
        id: "",
        name: "",
        description: "",
        variants: List.empty(),
      ),
    );

    yield currentState.copyWith(
      selectedProduct: product,
      selectedVariant: product.variants?.firstWhere(
        (element) =>
            element.name?.toLowerCase() ==
            collection.variantId?.toLowerCase(),
        orElse: () => Variant(
          id: null,
          img: null,
          example: null,
          name: null,
          measures: null,
        ),
      ),
    );
  }
}
