// ignore_for_file: camel_case_types, non_constant_identifier_names

part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class orderInitialEvent extends OrderEvent {}

class loadOrderEvent extends OrderEvent {
  final Product Orderproduct;

  loadOrderEvent({required this.Orderproduct});
}
