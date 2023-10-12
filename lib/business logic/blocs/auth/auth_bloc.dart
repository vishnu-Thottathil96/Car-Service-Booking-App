import 'package:bloc/bloc.dart';
import 'package:motox/data/repositories/auth_repository.dart';
import 'package:motox/utils/constants/enums.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthState(isSaving: true));
      AuthExceptions authExceptions =
          await AuthRepository.registerUsingEmailPassword(
              name: event.name, email: event.email, password: event.password);
      return emit(AuthState(isSaving: false, authExceptions: authExceptions));
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthState(isSaving: true));
      AuthExceptions authExceptions =
          await AuthRepository.loginUsingEmailPassword(
              email: event.email, password: event.password);
      return emit(AuthState(isSaving: false, authExceptions: authExceptions));
    });
  }
}
