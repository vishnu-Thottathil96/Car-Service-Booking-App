// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

class AuthState {
  final bool isSaving;
  final bool isLogin;
  final AuthExceptions authExceptions;
  AuthState({
    required this.isSaving,
    required this.authExceptions,
    this.isLogin = false,
  });
}

final class AuthInitial extends AuthState {
  AuthInitial()
      : super(isSaving: false, authExceptions: AuthExceptions.initial);
}
