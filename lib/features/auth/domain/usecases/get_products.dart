import 'package:my_myntra_app/features/auth/data/models/product_models.dart';
import 'package:my_myntra_app/features/auth/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<ProductModel>> call() {
    return repository.getProducts();
  }
}
