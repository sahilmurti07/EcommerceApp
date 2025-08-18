part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class orderLoadedstate extends OrderState {
  final Product orderProduct;

  orderLoadedstate({required this.orderProduct});
}
