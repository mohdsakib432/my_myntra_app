import 'package:my_myntra_app/features/auth/data/datasources/product_remote_data_source.dart';
import 'package:my_myntra_app/features/auth/data/models/product_models.dart';
import 'package:my_myntra_app/features/auth/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductModel>> getProducts() async {
    final products = await remoteDataSource.getProducts();
    return products;
  }
}
