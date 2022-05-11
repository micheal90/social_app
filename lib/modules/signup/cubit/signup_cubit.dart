import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/constants.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void userSignUp(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(SignupLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.email);

      createUser(name: name, email: email, phone: phone, uId: value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      emit(SignupError(error: error.toString()));
    });
  }

  void createUser(
      {required String name,
      required String email,
      required String phone,
      required String uId}) {
    UserModel model = UserModel(
        name: name,
        uId: uId,
        email: email,
        phone: phone,
        bio: 'Write your bio...',
        messageToken: messageToken ?? '',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/social-app-e5b23.appspot.com/o/profile-image.jpg?alt=media&token=7db5f9c0-776a-4df8-8bd1-f2fb86711350',
        cover:
            'https://firebasestorage.googleapis.com/v0/b/social-app-e5b23.appspot.com/o/cover.jpg?alt=media&token=d7313ef8-71d2-41f7-8a31-6dcfd9dff0a4');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SignupCreateSuccces(uId: uId));
    }).catchError((error) {
      emit(SignupCreateError(error: error.toString()));
    });
  }

  void changePasswordVisability() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_off_outlined;
    emit(SignupChangePasswordVisability());
  }
}
