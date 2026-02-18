import 'package:my_myntra_app/features/auth/data/models/product_models.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}
