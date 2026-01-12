class AuthState {
  final String username;
  final String email;
  final String password;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isAuthenticated;
  final bool isRegistered;

  AuthState({
    required this.username,
    required this.email,
    required this.password,
    required this.isSubmitting,
    this.errorMessage,
    required this.isAuthenticated,
    required this.isRegistered
  });

  factory AuthState.initial() {
    return AuthState(
      username: '',
      email: '',
      password: '',
      isSubmitting: false,
      errorMessage: null,
      isAuthenticated: false,
      isRegistered: false,
    );
  }

  AuthState copyWith({
    String? username,
    String? email,
    String? password,
    bool? isSubmitting,
    String? errorMessage,
    bool? isAuthenticated,
    bool? isRegistered,
  }) {
    return AuthState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isRegistered: isRegistered ?? this.isRegistered,
    );
  }
}
