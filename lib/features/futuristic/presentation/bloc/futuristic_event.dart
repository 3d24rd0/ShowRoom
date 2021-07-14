part of 'futuristic_bloc.dart';

@immutable
abstract class FuturisticEvent {
  Stream<FuturisticState> applyAsync(
      FuturisticState currentState, FuturisticBloc bloc);
}

class LoadEvent extends FuturisticEvent {
  @override
  Stream<FuturisticState> applyAsync(
    FuturisticState currentState,
    FuturisticBloc bloc,
  ) async* {
    var eProducts = await bloc.getProductsUsecase(NoParams());
    var eMaterials = await bloc.getMaterialsUsecase(NoParams());

    var materials = eMaterials.getOrElse(() => MaterialList());
    var products = eProducts.getOrElse(() => List.empty());

    yield InitializedState(
      materiales: materials.materiales ?? List.empty(),
      products: products,
      //selectedProducsId: materials.materiales?.first.products,
      variants: List.empty()
    );
  }
}

class SelectMaterialEvent extends FuturisticEvent {
  final List<String>? products;
  final String name;

  SelectMaterialEvent(this.products, this.name);

  @override
  Stream<FuturisticState> applyAsync(
    FuturisticState currentState,
    FuturisticBloc bloc,
  ) async* {
    yield bloc.state
        .copyWith(selectedProducsId: List.empty(), variants: List.empty());
    await Future.delayed(Duration(milliseconds: 500));
    yield bloc.state
        .copyWith(selectedProducsId: products, variants: List.empty(), selectedMaterial: name);
  }
}

class SelectProductEvent extends FuturisticEvent {
  final Product? product;

  SelectProductEvent(this.product);

  @override
  Stream<FuturisticState> applyAsync(
    FuturisticState currentState,
    FuturisticBloc bloc,
  ) async* {
  

    yield bloc.state.copyWith(variants: product?.variants);
  }
}

class ShowNotesEvent extends FuturisticEvent {
  final bool show;

  ShowNotesEvent(this.show);

  @override
  Stream<FuturisticState> applyAsync(
    FuturisticState currentState,
    FuturisticBloc bloc,
  ) async* {
    yield bloc.state.copyWith(showNotes: show);
  }
}
