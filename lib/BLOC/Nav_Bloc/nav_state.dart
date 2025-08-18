part of 'nav_bloc.dart';

@immutable
abstract class NavState {
  final int index;

  const NavState(this.index);
}

class NavInitial extends NavState {
  const NavInitial() : super(0);
}

class NavigationChanged extends NavState {
  const NavigationChanged(int index) : super(index);
}
