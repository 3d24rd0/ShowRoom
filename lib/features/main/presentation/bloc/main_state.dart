part of 'main_bloc.dart';

@immutable
abstract class MainState {
  MainState();
}

class UninitializedState extends MainState {
  UninitializedState() : super();
}

class InitializedState extends MainState {
  InitializedState() : super();
}
