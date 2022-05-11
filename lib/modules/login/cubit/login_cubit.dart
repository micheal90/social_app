import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/services/local/cash_helper.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void userLogin({required String email, required String password}) {
    emit(LoginLoading());
    print(email);
    print(password);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccces(uId: value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(LoginError(error: error.toString()));
    });
  }

  void changePasswordVisability() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisability());
  }
}
