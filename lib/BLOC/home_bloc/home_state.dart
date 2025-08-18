part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

//all these are state
class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadingSuccessState extends HomeState {
  final List<Product> product_list;

  HomeLoadingSuccessState({required this.product_list});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});
}

//////////////////////////////////////////////////////

//all these are Action state
class HomeWishListIconClick extends HomeActionState {}

class HomeCartIconClick extends HomeActionState {}

class HomeProductsWishListIconClick extends HomeActionState {}

class NavigateToDescriptionPageActionState extends HomeActionState {
  final Product product;

  NavigateToDescriptionPageActionState(this.product);
}
