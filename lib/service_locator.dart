import 'package:get_it/get_it.dart';
import 'package:showroom/core/route/bloc/router_bloc.dart';
import 'package:showroom/features/hall/presentation/bloc/hall_bloc.dart';
import 'package:showroom/features/panel/data/repositories/product_repository_asset_json.dart';
import 'package:showroom/features/panel/domain/repositories/panel_repository.dart';
import 'package:showroom/features/panel/domain/usecases/get_collection_panel_usecase.dart';
import 'package:showroom/features/panel/presentation/bloc/panel_bloc.dart';
import 'package:showroom/core/data/datasources/assets_datasource.dart';
import 'package:showroom/features/products/data/repositories/product_repository_asset_json.dart';
import 'package:showroom/features/products/domain/repositories/product_repository.dart';
import 'package:showroom/features/products/domain/usecases/get_colletion_usecase.dart';
import 'package:showroom/features/products/domain/usecases/get_products_usecase.dart';
import 'package:showroom/features/products/presentation/bloc/product_bloc.dart';

GetIt getIt = GetIt.I;

Future<void> setUpLocator() async {
  _core();
  // Features
  _productsFeature();
  _hallFeature();
  _panelsFeature();
}

void _core() {
  //rRouter
  getIt.registerSingleton(RouterBloc());
  // Data sources
  getIt.registerLazySingleton<AssetsDatasource>(
    () => AssetsDatasourceImpl(
      productsPatch: 'assets/products.json',
      panelPatch: 'assets/panel{id}.json',
    ),
  );
}

void _productsFeature() {
  //Bloc
  getIt.registerFactory(
    () => ProductBloc(
      getProductsUsecase: getIt(),
    ),
  );
  // Use cases
  getIt.registerLazySingleton<GetProductsUsecase>(
      () => GetProductsUsecase(repository: getIt()));
  getIt.registerLazySingleton<GetCollectionUsecase>(
      () => GetCollectionUsecase(repository: getIt()));
  // Repository
  getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryAssetJson(
            assetsDatasource: getIt(),
          ));
}

void _hallFeature() {
  //Bloc
  getIt.registerFactory(
    () => HallBloc(),
  );
}

void _panelsFeature() {
  //Bloc
  getIt.registerFactory(
    () => PanelBloc(getIt(), getIt()),
  );

  // Use cases
  getIt.registerLazySingleton<GetCollectionPanelUsecase>(
      () => GetCollectionPanelUsecase(repository: getIt()));
  // Repository
  getIt.registerLazySingleton<PanelRepository>(
    () => PanelRepositoryAssetJson(
      assetsDatasource: getIt(),
    ),
  );
}
