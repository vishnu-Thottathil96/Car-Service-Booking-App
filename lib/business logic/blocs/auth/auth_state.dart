// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

class AuthState {
  final bool isSaving;
  final AuthExceptions? authExceptions;
  AuthState({
    required this.isSaving,
    this.authExceptions,
  });
}

final class AuthInitial extends AuthState {
  AuthInitial() : super(isSaving: false);
}
