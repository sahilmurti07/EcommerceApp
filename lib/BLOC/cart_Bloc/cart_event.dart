part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class cartInitialEvent extends CartEvent {}

class AddProductToCartEvent extends CartEvent {
  final Product product;

  AddProductToCartEvent({required this.product});
}

class RemoveProductToCartEvent extends CartEvent {
  final Product product;

  RemoveProductToCartEvent({required this.product});
}
