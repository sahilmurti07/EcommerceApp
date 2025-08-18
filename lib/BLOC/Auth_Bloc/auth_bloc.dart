import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final supabase = Supabase.instance.client;
  AuthBloc() : super(AuthInitial()) {
    on<checkAuthEvent>((event, emit) async {
      final session = supabase.auth.currentSession;
      // ignore: unnecessary_null_comparison
      if (session != null && session.user != null) {
        emit(AuthSuccess(email: session.user.email ?? ""));
      } else {
        emit(AuthInitial());
      }
    });
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await supabase.auth.signUp(
          password: event.password,
          email: event.email,
        );
        if (response.user != null) {
          emit(AuthSuccess(email: response.user!.email ?? ""));
        } else {
          emit(AuthFailure(error: "Sign up failed"));
        }
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await supabase.auth.signInWithPassword(
          password: event.password,
          email: event.email,
        );
        if (response.user != null) {
          emit(AuthSuccess(email: response.user!.email ?? ""));
        } else {
          emit(AuthFailure(error: "Login failed"));
        }
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
    on<logoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await supabase.auth.signOut();
        emit(AuthLoggedOut());
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
  }
}
