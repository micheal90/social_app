part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccces extends SignupState {}

class SignupError extends SignupState {
  final String error;
  SignupError({
    required this.error,
  });
}

class SignupCreateSuccces extends SignupState {
  final String uId;
  SignupCreateSuccces({
    required this.uId,
  });
}

class SignupCreateError extends SignupState {
  final String error;
  SignupCreateError({
    required this.error,
  });
}

class SignupChangePasswordVisability extends SignupState {}
