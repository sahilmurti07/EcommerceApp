part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String email;

  AuthSuccess({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class AuthLoggedOut extends AuthState {}
