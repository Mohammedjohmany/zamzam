part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent{
  final UserModel userModel;

  LoginEvent({required this.userModel});
  
}
class SignUpEvent extends AuthEvent{
  final RegisterModel registerModel ;

  SignUpEvent({required this.registerModel});

}
