abstract class AuthEvent {}

class AuthEmailChanged extends AuthEvent{
  final String email;
  AuthEmailChanged(this.email);
}

class AuthPasswordChanged extends AuthEvent {
  final String password;
  AuthPasswordChanged(this.password);
}

class AuthLoginRequested extends AuthEvent {}

class AuthLogoutRequested extends AuthEvent {}

class RegisterUser extends AuthEvent {
  final String email;
  final String password;
  final String username;

  RegisterUser({
    required this.email,
    required this.password,
    required this.username,
  });
}

class FetchUserData extends AuthEvent {}