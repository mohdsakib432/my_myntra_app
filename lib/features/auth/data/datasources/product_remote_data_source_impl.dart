import 'package:dio/dio.dart';
import 'package:my_myntra_app/core/api/api_routes.dart';
import '../models/product_models.dart';
import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get(ApiRoutes.products);

    return (response.data as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }
}
