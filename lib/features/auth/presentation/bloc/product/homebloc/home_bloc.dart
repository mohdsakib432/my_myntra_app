import 'package:bloc/bloc.dart';
import 'package:my_myntra_app/features/auth/domain/usecases/get_products.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/product/homebloc/home_event.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/product/homebloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProducts getProduct;
  HomeBloc(this.getProduct) : super(HomeInitialc()) {
    on<Fetchproduct>((event, emit) async {
      emit(HomeLoading());
      try {
        final product = await getProduct();
        emit(HomeLoaded(product));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
