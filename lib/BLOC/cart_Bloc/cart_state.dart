part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class cartLoadingState extends CartState {}

class cartUpdateState extends CartState {
  final List<Product> cartItems;

  cartUpdateState({required this.cartItems});
}
