part of 'hall_bloc.dart';

@immutable
abstract class HallEvent {
  Stream<HallState> applyAsync({HallState? currentState, HallBloc? bloc});
}

class NavigateToTotemEvent extends HallEvent {
  final String id;

  NavigateToTotemEvent(this.id);

  @override
  Stream<HallState> applyAsync({currentState, bloc}) async* {
    getIt<RouterBloc>().add(TotemEvent(id));
  }
}

class NavigateToPanelEvent extends HallEvent {
  final String id;

  NavigateToPanelEvent(this.id);

  @override
  Stream<HallState> applyAsync({currentState, bloc}) async* {
    getIt<RouterBloc>().add(PanelEvent(id));
  }
}

class NavigateToProductsEvent extends HallEvent {

  @override
  Stream<HallState> applyAsync({currentState, bloc}) async* {
    getIt<RouterBloc>().add(ProductsEvent());
  }
}
