import 'package:bloc/bloc.dart';
import 'package:personal_finances/blocs/auth/auth_event.dart';
import 'package:personal_finances/blocs/auth/auth_state.dart';
import 'package:personal_finances/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState.initial()) {
    on<AuthEmailChanged>((event, emit) {
      emit(state.copyWhit(email: event.email));
    });

    on<AuthPasswordChanged>((event, emit) {
      emit(state.copyWhit(password: event.password));
    });

    on<AuthLoginRequested>((event, emit) async {
      emit(state.copyWhit(isSubmitting: true, errorMessage: null));
      try {
        await authRepository.signInWithEmailAndPassword(state.email, state.password);

        emit(state.copyWhit(isSubmitting: false, isAuthenticated: true));
      } catch (e) {
        emit(state.copyWhit(isSubmitting: false, errorMessage: e.toString()));
      }
    });

    on<AuthLogoutRequested>((event, emit) async {
      await authRepository.signOut();
      emit(state.copyWhit(isSubmitting: false, isAuthenticated: false));
    });
  }
}
