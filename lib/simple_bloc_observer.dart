import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(bloc, event) {
    developer.log('$event', name: 'SimpleBlocObserver');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    developer.log('$transition', name: 'SimpleBlocObserver');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    developer.log('$error',
        name: 'SimpleBlocObserver', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
