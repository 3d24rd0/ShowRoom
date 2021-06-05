import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:showroom/features/panel/domain/entities/collection.dart';
import 'package:showroom/features/panel/domain/entities/collection_panel.dart';
import 'dart:developer' as developer;

import 'package:showroom/features/panel/domain/usecases/get_collection_panel_usecase.dart';
import 'package:showroom/features/products/domain/entities/product.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';
import 'package:showroom/features/products/domain/usecases/get_colletion_usecase.dart';

part 'panel_event.dart';
part 'panel_state.dart';

class PanelBloc extends Bloc<PanelEvent, PanelState> {
  final GetCollectionPanelUsecase getCollectionPanelUsecase;
  final GetCollectionUsecase getCollectionUsecase;
  PanelBloc(this.getCollectionPanelUsecase, this.getCollectionUsecase) : super(UninitializedState());

  @override
  Stream<PanelState> mapEventToState(
    PanelEvent event,
  ) async* {
    try {
      yield* event.applyAsync( state, this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'PanelBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
