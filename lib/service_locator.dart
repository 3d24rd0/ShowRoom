import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:showroom/core/data/datasources/local_data_source.dart';
import 'package:showroom/features/main/presentation/bloc/main_bloc.dart';

GetIt getIt = GetIt.I;

Future<void> setUpLocator() async {
  bool debug = _checkDebugMode();

  await Hive.initFlutter("showroom");
  //Hive.registerAdapter(RecipeAdapter());
  // Core
  _core();

  // Features
  _mainFeature();
}

bool _checkDebugMode() {
  bool _debug = false;
  assert(() {
    _debug = true;
    return true;
  }());
  return _debug;
}

void _core() {
  //Router
  // getIt.registerSingleton(RouterBloc());

  // Data sources
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl()..initialization,
  );
}

void _mainFeature() {
  //Bloc
  getIt.registerFactory(
    () => MainBloc(),
  );
  // Use cases

  // Repository

  // Data sources
}
