part of 'nav_bloc.dart';

@immutable
abstract class NavEvent {}

class ChangeTabEvent extends NavEvent {
  final int index;
  ChangeTabEvent(this.index);
}
