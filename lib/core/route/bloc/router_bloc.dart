import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../custom_router.dart';

part 'router_event.dart';
part 'router_state.dart';

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  RouterBloc() : super(RouterInitial());

  @override
  Stream<RouterState> mapEventToState(
    RouterEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this, navigatorKey: navigatorKey.currentState);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'RouterBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}