part of 'router_bloc.dart';

abstract class RouterEvent {
  Stream<RouterState> applyAsync(
      {RouterState? currentState,
      RouterBloc? bloc,
      NavigatorState? navigatorKey});
}

class ProductsEvent extends RouterEvent {
  @override
  Stream<RouterState> applyAsync(
      {RouterState? currentState,
      RouterBloc? bloc,
      NavigatorState? navigatorKey}) async* {
    navigatorKey?.pushNamed(CustomRouter.products);
  }
}

class TotemEvent extends RouterEvent {
  final String id;

  TotemEvent(this.id);

  @override
  Stream<RouterState> applyAsync(
      {RouterState? currentState,
      RouterBloc? bloc,
      NavigatorState? navigatorKey}) async* {
    navigatorKey?.pushNamed(CustomRouter.totem, arguments: id);
  }
}

class PanelEvent extends RouterEvent {
  final String id;

  PanelEvent(this.id);

  @override
  Stream<RouterState> applyAsync(
      {RouterState? currentState,
      RouterBloc? bloc,
      NavigatorState? navigatorKey}) async* {
    navigatorKey?.pushNamed(CustomRouter.panel, arguments: id);
  }
}

class MultiTouchEvent extends RouterEvent {
  @override
  Stream<RouterState> applyAsync(
      {RouterState? currentState,
      RouterBloc? bloc,
      NavigatorState? navigatorKey}) async* {
    navigatorKey?.pushNamed(CustomRouter.multitouch);
  }
}
