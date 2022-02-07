import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/constants.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());
  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  File? profileImage;
  File? coverImage;
  var image = ImagePicker();

  void getUserData() {
    emit(SocialLoading());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromMap(value.data()!);
      print(userModel?.email);
      emit(SocialGetUserSuccess());
    }).catchError((error) {
      print(error);
      emit(SocialGetUserError(error: error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingsScreen()
  ];
  List<String> titles = ['Home', 'Chats', 'Users', 'Settings'];
  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(SocialChangeBottomNav());
  }

  Future pickImage() async {
    final pickedFile =
        await image.pickImage(source: ImageSource.gallery, imageQuality: 75);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      //save imagefile in db and get url
      emit(SocialProfileImagePickedSuccess());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedSuccess());
    }
  }

  Future pickCover() async {
    final pickedFile =
        await image.pickImage(source: ImageSource.gallery, imageQuality: 75);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      //save imagefile in db and get url
      emit(SocialCoverImagePickedSuccess());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedError());
    }
  }
}
