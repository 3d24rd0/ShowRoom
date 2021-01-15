import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(UninitializedState());
  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'CardFormBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
