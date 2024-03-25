import 'package:bloc/bloc.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      // emit(AuthLoading());
      emit(AuthLoading());
      final response = await _userSignUp(
        UserSignUpParams(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );

      response.fold(
        (fail) => emit(AuthFailure(fail.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });
  }
}
