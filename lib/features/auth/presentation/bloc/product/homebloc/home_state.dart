import 'package:my_myntra_app/features/auth/data/models/product_models.dart';

abstract class HomeState {}

class HomeInitialc extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductModel> product;
  HomeLoaded(this.product);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
