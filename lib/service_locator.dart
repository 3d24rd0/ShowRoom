import 'package:get_it/get_it.dart';
import 'package:showroom/core/data/datasources/local_data_source.dart';
import 'package:showroom/features/main/data/datasources/assets_datasource.dart';
import 'package:showroom/features/main/data/repositories/product_repository_asset_json.dart';
import 'package:showroom/features/main/domain/repositories/product_repository.dart';
import 'package:showroom/features/main/domain/usecases/get_products_usecase.dart';
import 'package:showroom/features/main/presentation/bloc/main_bloc.dart';

GetIt getIt = GetIt.I;

Future<void> setUpLocator() async {
  bool debug = _checkDebugMode();

  // await Hive.initFlutter("showroom");
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
    () => MainBloc(getIt()),
  );
  // Use cases
  getIt.registerLazySingleton<GetProductsUsecase>(
      () => GetProductsUsecase(repository: getIt()));
  // Repository
  getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryAssetJson(assetsDatasource: getIt()));
  // Data sources
  getIt.registerLazySingleton<AssetsDatasource>(
      () => AssetsDatasourceImpl(productsPatch: 'assets/products.json'));
}
