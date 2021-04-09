import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:showroom/core/route/bloc/router_bloc.dart';
import 'package:showroom/service_locator.dart';

part 'hall_event.dart';
part 'hall_state.dart';

class HallBloc extends Bloc<HallEvent, HallState> {
  HallBloc() : super(InitializedState());
  @override
  mapEventToState(
    event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'HallBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
