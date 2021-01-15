import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    developer.log('$event', name: 'SimpleBlocObserver');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    developer.log('$transition', name: 'SimpleBlocObserver');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    developer.log('$error',
        name: 'SimpleBlocObserver', error: error, stackTrace: stackTrace);
    super.onError(cubit, error, stackTrace);
  }
}
