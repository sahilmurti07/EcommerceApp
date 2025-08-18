import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/data/productModel.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<Product> _cartItems = [];
  CartBloc() : super(CartInitial()) {
    on<cartInitialEvent>((event, emit) {
      emit(cartLoadingState());
      emit(cartUpdateState(cartItems: List.from(_cartItems)));
    });
    on<AddProductToCartEvent>((event, emit) {
      _cartItems.add(event.product);
      emit(cartUpdateState(cartItems: List.from(_cartItems)));
    });
    on<RemoveProductToCartEvent>((event, emit) {
      _cartItems.remove(event.product);
      emit(cartUpdateState(cartItems: List.from(_cartItems)));
    });
  }
}
