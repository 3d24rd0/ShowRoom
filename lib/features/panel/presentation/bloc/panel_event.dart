part of 'panel_bloc.dart';

@immutable
abstract class PanelEvent {
  Stream<PanelState> applyAsync({PanelState? currentState, PanelBloc? bloc});
}

class LoadEvent extends PanelEvent {
  final String id;

  LoadEvent(this.id);

  @override
  Stream<PanelState> applyAsync({currentState, bloc}) async* {
    var eCollectionPanel = await bloc?.getCollectionPanelUsecase(id);
    CollectionPanel? collectionPanel = eCollectionPanel?.getOrElse(
      () => CollectionPanel(
        leftCollection: List.empty(),
        rightCollection: List.empty(),
      ),
    );

    var first = collectionPanel?.leftCollection.first;

    yield InitializedState(
      panelID: id,
      collectionPanel: collectionPanel,
      selectedProduct: null,
      selectedVariant: null,
    );

    bloc?.add(SelectEvent(first ?? Collection(name: "",variantName: "",)));
  }
}

class SelectEvent extends PanelEvent {
  final Collection collection;

  SelectEvent(this.collection);

  @override
  Stream<PanelState> applyAsync({currentState, bloc}) async* {
    print(collection.variantName);
    var eProduct = await bloc?.getCollectionUsecase(collection.name ?? "");
    var product = eProduct?.getOrElse(
      () => Product(
        name: "",
        description: "",
        variants: List.empty(),
      ),
    );

    PanelState e = currentState?.copyWith(
      selectedProduct: product,
      selectedVariant: product?.variants?.firstWhere(
        (element) =>
            element.name?.toLowerCase() ==
            collection.variantName?.toLowerCase(),
            orElse: null,
      ),
    );
    yield e;
  }
}
