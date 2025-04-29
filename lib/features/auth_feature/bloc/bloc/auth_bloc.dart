import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:zamzam/features/auth_feature/model/register_model.dart';
import 'package:zamzam/features/auth_feature/model/user_model.dart';
import 'package:zamzam/features/auth_feature/service/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthService authService;
  AuthBloc(
    this.authService,
  ) : super(AuthInitial()) {
    on<SignUpEvent>(
      (event, emit) async {
        emit(LoadingState());
        bool status = await authService.signUp(event.registerModel);
        if (status) {
          emit(SuccessRegisterState());
        } else {
          emit(ErrorState(error: 'SignUp Failed'));
        }
      },
    );
    on<LoginEvent>((event, emit) async {
      emit(LoadingState());
      bool status = await authService.login(event.userModel);
      if (status) {
        emit(SuccessLoginState());
      } else {
        emit(ErrorState(error: 'Login Falied'));
      }
    },);
  }
}

