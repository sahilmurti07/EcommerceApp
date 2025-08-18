import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/services/product_services.dart';
import 'package:flutter_application_1/data/productModel.dart';
import 'package:meta/meta.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        final productData = await ProductServices().fetchProducts();
        emit(HomeLoadingSuccessState(product_list: productData.products));
      } catch (e) {
        emit(HomeErrorState(message: "error:$e"));
      }
    });
    on<NavigateToDetailPageEvent>((event, emit) {
      emit(NavigateToDescriptionPageActionState(event.product));
    });
  }
}
