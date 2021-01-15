part of 'main_bloc.dart';

@immutable
abstract class MainEvent {
  Stream<MainState> applyAsync({MainState currentState, MainBloc bloc});
}

class LoadEvent extends MainEvent {
  @override
  Stream<MainState> applyAsync({MainState currentState, MainBloc bloc}) async* {
    yield InitializedState();
  }
}
