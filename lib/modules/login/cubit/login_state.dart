part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccces extends LoginState {
  final String uId;
  LoginSuccces({
    required this.uId,
  });
}

class LoginError extends LoginState {
  final String error;
  LoginError({
    required this.error,
  });
}

class LoginChangePasswordVisability extends LoginState {}
