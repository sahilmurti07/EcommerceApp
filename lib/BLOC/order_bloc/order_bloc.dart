import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/data/productModel.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<orderInitialEvent>((event, emit) {
      emit(OrderLoadingState());
    });
    on<loadOrderEvent>((event, emit) {
      emit(orderLoadedstate(orderProduct: event.Orderproduct));
    });
  }
}
