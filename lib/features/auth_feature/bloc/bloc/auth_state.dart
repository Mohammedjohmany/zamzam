part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class SuccessRegisterState extends AuthState {}

class SuccessLoginState extends AuthState {}

class ErrorState extends AuthState {
 final String error;

  ErrorState({required this.error});
}

class LoadingState extends AuthState {}