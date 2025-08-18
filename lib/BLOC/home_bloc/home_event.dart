part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class productTileClickedEvent extends HomeEvent {
  final Product product;

  productTileClickedEvent(this.product);
}

class NavigateToDetailPageEvent extends HomeEvent {
  final Product product;

  NavigateToDetailPageEvent(this.product);
}
