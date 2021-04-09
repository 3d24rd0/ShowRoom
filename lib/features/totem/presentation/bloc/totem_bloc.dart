import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'totem_event.dart';
part 'totem_state.dart';
class TotemBloc extends Bloc<TotemEvent, TotemState> {
  TotemBloc() : super(TotemInitial());
  @override
  Stream<TotemState> mapEventToState(
    TotemEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
