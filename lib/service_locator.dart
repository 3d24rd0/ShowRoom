import 'package:get_it/get_it.dart';
import 'package:showroom/features/products/data/datasources/assets_datasource.dart';
import 'package:showroom/features/products/data/datasources/nfc_datasource.dart';
import 'package:showroom/features/products/data/repositories/product_repository_asset_json.dart';
import 'package:showroom/features/products/domain/repositories/product_repository.dart';
import 'package:showroom/features/products/domain/usecases/get_products_usecase.dart';
import 'package:showroom/features/products/presentation/bloc/product_bloc.dart';

GetIt getIt = GetIt.I;

Future<void> setUpLocator() async {
  // Features
  _mainFeature();
}

void _mainFeature() {
  //Bloc
  getIt.registerFactory(
    () => ProductBloc(
      getIt(),
    ),
  );
  // Use cases
  getIt.registerLazySingleton<GetProductsUsecase>(
      () => GetProductsUsecase(repository: getIt()));
  // Repository
  getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryAssetJson(
            assetsDatasource: getIt(),
          ));
  // Data sources
  getIt.registerLazySingleton<AssetsDatasource>(
      () => AssetsDatasourceImpl(productsPatch: 'assets/products.json'));

  getIt.registerLazySingleton<NfcDatasource>(
      () => NfcDatasourceExternalProgress());
}
