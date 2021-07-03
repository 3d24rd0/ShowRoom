import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'futuristic_event.dart';
part 'futuristic_state.dart';
class FuturisticBloc extends Bloc<FuturisticEvent, FuturisticState> {
  FuturisticBloc() : super(FuturisticInitial());
  @override
  Stream<FuturisticState> mapEventToState(
    FuturisticEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
