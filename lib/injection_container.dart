import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/product/homebloc/home_bloc.dart';
import 'features/auth/presentation/bloc/product/product_bloc.dart';
import 'features/auth/domain/usecases/get_products.dart';
import 'features/auth/domain/repositories/product_repository.dart';
import 'features/auth/domain/repositories/product_repository_impl.dart';
import 'features/auth/data/datasources/product_remote_data_source.dart';
import 'features/auth/data/datasources/product_remote_data_source_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Dio
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
    return dio;
  });

  // Data source
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  // Use case
  sl.registerLazySingleton(() => GetProducts(sl()));

  // Bloc
  sl.registerFactory(() => ProductBloc(sl()));
  sl.registerFactory(() => HomeBloc(sl()));
}
