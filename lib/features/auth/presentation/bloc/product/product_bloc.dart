import 'package:my_myntra_app/features/auth/domain/usecases/get_products.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/product/product_event.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/product/product_state.dart';
import 'package:bloc/bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc(this.getProducts) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
