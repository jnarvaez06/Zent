import 'package:bloc/bloc.dart';
import 'package:personal_finances/blocs/auth/auth_event.dart';
import 'package:personal_finances/blocs/auth/auth_state.dart';
import 'package:personal_finances/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState.initial()) {
    on<AuthEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<AuthPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<AuthLoginRequested>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, errorMessage: null));
      try {
        await authRepository.signInWithEmailAndPassword(state.email, state.password);

        emit(state.copyWith(isSubmitting: false, isAuthenticated: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
      }
    });

    on<AuthLogoutRequested>((event, emit) async {
      try {
        await authRepository.signOut();
        emit(state.copyWith(isSubmitting: false, isAuthenticated: false));        
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, isAuthenticated: false, errorMessage: e.toString()));
      }
    });

    on<RegisterUser>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, errorMessage: null, isRegistered: false));
      try {
        await authRepository.register(event.username, event.email, event.password);
        emit(state.copyWith(username: event.username, isRegistered: true, isSubmitting: false));
      } catch (e) {
        emit(state.copyWith(errorMessage: e.toString(), isRegistered: false, isSubmitting: false));
      }
    });
  }
}
