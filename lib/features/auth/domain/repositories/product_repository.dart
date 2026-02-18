import 'package:my_myntra_app/features/auth/data/models/product_models.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
}
