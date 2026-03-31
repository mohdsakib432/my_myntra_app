import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:my_myntra_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_myntra_app/core/api/api_client.dart';
import 'package:my_myntra_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:my_myntra_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_myntra_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/product/homebloc/home_bloc.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/product/theme/theme_bloc.dart';

import 'features/auth/presentation/bloc/product/product_bloc.dart';
import 'features/auth/domain/usecases/get_products.dart';
import 'features/auth/domain/repositories/product_repository.dart';
import 'features/auth/domain/repositories/product_repository_impl.dart';
import 'features/auth/data/datasources/product_remote_data_source.dart';
import 'features/auth/data/datasources/product_remote_data_source_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ✅ SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // ✅ ApiClient (handles Dio)
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl()));

  // ✅ Dio (ONLY FROM ApiClient)
  sl.registerLazySingleton<Dio>(() => sl<ApiClient>().dio);

  // ================= PRODUCT =================

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetProducts(sl()));

  sl.registerFactory(() => ProductBloc(sl()));
  sl.registerFactory(() => HomeBloc(sl()));

  // ================= AUTH =================

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  sl.registerFactory(() => AuthBloc(sl(), sl(), sl()));

  // ================= THEME =================

  sl.registerFactory(() => ThemeBloc());
}
