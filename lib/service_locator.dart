import 'package:get_it/get_it.dart';
import 'package:showroom/features/main/data/datasources/assets_datasource.dart';
import 'package:showroom/features/main/data/datasources/nfc_datasource.dart';
import 'package:showroom/features/main/data/repositories/product_repository_asset_json.dart';
import 'package:showroom/features/main/domain/repositories/product_repository.dart';
import 'package:showroom/features/main/domain/usecases/get_client_id_usecase.dart';
import 'package:showroom/features/main/domain/usecases/get_products_usecase.dart';
import 'package:showroom/features/main/presentation/bloc/main_bloc.dart';

GetIt getIt = GetIt.I;

Future<void> setUpLocator() async {
  // Features
  _mainFeature();
}

void _mainFeature() {
  //Bloc
  getIt.registerFactory(
    () => MainBloc(getIt(), getIt()),
  );
  // Use cases
  getIt.registerLazySingleton<GetProductsUsecase>(
      () => GetProductsUsecase(repository: getIt()));
  getIt.registerLazySingleton<GetClientIdUsecase>(
      () => GetClientIdUsecase(repository: getIt()));
  // Repository
  getIt.registerLazySingleton<ProductRepository>(() =>
      ProductRepositoryAssetJson(
          assetsDatasource: getIt(), nfcDatasource: getIt()));
  // Data sources
  getIt.registerLazySingleton<AssetsDatasource>(
      () => AssetsDatasourceImpl(productsPatch: 'assets/products.json'));

  getIt.registerLazySingleton<NfcDatasource>(
      () => NfcDatasourceExternalProgress());
}
