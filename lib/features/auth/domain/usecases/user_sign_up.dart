import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usercase.dart';
import 'package:blog_app/features/auth/domain/repository/auth-repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;

  const UserSignUp({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    // dont forget to use await becoz sometimes it will takes some time
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
