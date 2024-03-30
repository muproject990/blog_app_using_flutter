part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final User user;

  const AppUserLoggedIn(this.user);
}

// core is indpendent and other are dependent on core