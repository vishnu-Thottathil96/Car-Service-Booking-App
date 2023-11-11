import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motox/data/models/model_user.dart';
import 'package:motox/data/repositories/auth_repository.dart';
import 'package:motox/data/repositories/user_repository.dart';
import 'package:motox/utils/constants/enums.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthState(isSaving: true, authExceptions: AuthExceptions.initial));
      AuthExceptions authExceptions =
          await AuthRepository.registerUsingEmailPassword(
              name: event.name, email: event.email, password: event.password);
      if (authExceptions == AuthExceptions.signUpSuccess) {
        // User signup was successful
        // Retrieve the user's ID from Firebase Authentication
        String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

        // Save the user data with the retrieved ID
        await UserRepository.saveUserData(
            UserModel(id: userId, name: event.name, email: event.email));
      }
      return emit(AuthState(isSaving: false, authExceptions: authExceptions));
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthState(isSaving: true, authExceptions: AuthExceptions.initial));
      AuthExceptions authExceptions =
          await AuthRepository.loginUsingEmailPassword(
              email: event.email, password: event.password);
      return emit(AuthState(isSaving: false, authExceptions: authExceptions));
    });
    on<MailVerificationEvent>((event, emit) async {
      emit(AuthState(isSaving: false, authExceptions: AuthExceptions.initial));
      AuthExceptions authExceptions = await AuthRepository.verifyMail();
      emit(AuthState(isSaving: false, authExceptions: authExceptions));
    });
  }
}
