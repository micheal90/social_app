import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/services/local/cash_helper.dart';
import 'package:social_app/shared/services/local/messaging.dart';
import 'package:social_app/shared/services/remote/dio_helper.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());
  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  File? profileImage;
  File? coverImage;
  File? postImage;
  var image = ImagePicker();

  

  //bottom nav bar
  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingsScreen()
  ];
  List<String> titles = ['Home', 'Chats', 'Users', 'Settings'];
  void changeBottomNavIndex(int index) {
    if (index == 1) getAllUsers();
    currentIndex = index;
    emit(SocialChangeBottomNav());
  }

  void getUserData() {
    emit(SocialGetUserLoading());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromMap(value.data()!);
      print(userModel?.email);
      emit(SocialGetUserSuccess());
    }).catchError((error) {
      print(error);
      emit(SocialGetUserError(error: error.toString()));
    });
  }

  List<PostModel> posts = [];

  void getPosts() {
    // posts.clear();
    emit(SocialGetPostsLoading());
    // FirebaseFirestore.instance
    //     .collection('posts')
    //     .orderBy('dateTime', descending: true)
    //     .get()
    //     .then((value) {
    //   for (var post in value.docs) {
    //     posts.add(PostModel.fromMap(post.data()));
    //   }
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      posts.clear();
      for (var post in event.docs) {
        posts.add(PostModel.fromMap(post.data()));
      }
      emit(SocialGetPostsSuccess());
    });
  }

  List<UserModel> users = [];
  void getAllUsers() {
    emit(SocialGetAllUsersLoading());
    users.clear();

    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != userModel!.uId) {
          users.add(UserModel.fromMap(element.data()));
        }
      }
      emit(SocialGetAllUsersSuccess());
    }).catchError((error) {
      emit(SocialGetAllUsersError(error: error.toString()));
    });
  }

  UserModel findUserById(String uId) {
    return users.firstWhere((element) => element.uId == uId);
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
      emit(SocialCoverImagePickedSuccess());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedError());
    }
  }

  void uploadProfileImage() async {
    emit(SocialUploadProfileImageLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((imageUrl) {
        updateUserData(imageProfileUrl: imageUrl);
        emit(SocialUploadProfileImageSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageError());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageError());
    });
  }

  void uploadCoverImage() async {
    emit(SocialUploadCoverImageLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((coverUrl) {
        updateUserData(coverImageUrl: coverUrl);
        emit(SocialUploadCoverImageSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageError());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageError());
    });
  }

  void updateUserData(
      {String? name,
      String? phone,
      String? bio,
      String? imageProfileUrl,
      String? coverImageUrl}) async {
    emit(SocialUpdateUserDataLoading());
    UserModel updateModel = UserModel(
        name: name ?? userModel!.name,
        phone: phone ?? userModel!.phone,
        bio: bio ?? userModel!.bio,
        imageUrl: imageProfileUrl ?? userModel!.imageUrl,
        cover: coverImageUrl ?? userModel!.cover,
        email: userModel!.email,
        uId: userModel!.uId,
        messageToken: userModel!.messageToken,
        isVerified: userModel!.isVerified);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(updateModel.toMap())
        .then((value) {
      getUserData();
      profileImage = null;
      coverImage = null;
    }).catchError((error) {
      emit(SocialUpdateUserDataError());
    });
  }

  //post functions
  Future pickPostImage() async {
    final pickedFile =
        await image.pickImage(source: ImageSource.gallery, imageQuality: 75);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      //save imagefile in db and get url
      emit(SocialPostImagePickedSuccess());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedError());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) async {
    emit(SocialUpdatePostLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((imageUrl) {
        updatePostData(dateTime: dateTime, text: text, postImagUrl: imageUrl);
        emit(SocialUploadPostImageSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadPostImageError());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadPostImageError());
    });
  }

  List<String> tags = [];
  void addTag(String text) {
    var seperateTags = text.split(' ');
    for (var element in seperateTags) {
      tags.add(element);
    }
    emit(SocialAddTagSuccess());
  }

  void updatePostData(
      {required String dateTime,
      required String text,
      String? postImagUrl}) async {
    emit(SocialUpdatePostLoading());

    var docId = FirebaseFirestore.instance.collection('posts').doc();
    docId
        .set(
      PostModel(
              uId: userModel!.uId,
              name: userModel!.name,
              dateTime: dateTime,
              image: userModel!.imageUrl,
              text: text,
              postId: docId.id,
              postImage: postImagUrl ?? '',
              likes: [],
              comments: [],
              tags: tags)
          .toMap(),
    )
        .then((value) {
      emit(SocialUpdatePostSuccess());
      removePostImage();
      tags.clear();
      // getPosts();
    }).catchError((error) {
      emit(SocialUpdatePostError());
    });
  }

  void likePost(String postId) {
    var post = findPostById(postId);

    if (post.likes.contains(userModel!.uId)) {
      post.likes.remove(userModel!.uId);

      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update(post.toMap())
          .then((value) {
        //getPosts();
        emit(SocialLikePostSuccess());
      }).catchError((error) {
        emit(SocialLikePostError(error: error.toString()));
      });
    } else {
      post.likes.add(userModel!.uId);

      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update(post.toMap())
          .then((value) {
        //getPosts();
        emit(SocialLikePostSuccess());
      }).catchError((error) {
        emit(SocialLikePostError(error: error.toString()));
      });
    }
  }

  void addComment(String postId, String comment) {
    var post = findPostById(postId);

    post.comments.add(PostComment(
        userId: userModel!.uId,
        value: comment,
        name: userModel!.name,
        imageUrl: userModel!.imageUrl));

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update(post.toMap())
        .then((value) {
      //getPosts();
      emit(SocialAddCommentToPostSuccess());
    }).catchError((error) {
      emit(SocialAddCommentToPostError(error: error.toString()));
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialPostImageRemove());
  }

  void removeTagsList() {
    tags.clear();
    emit(SocialRemoveTagsListSuccess());
  }

  void sendMessage(
      {required String recieverId,
      required String recierverName,
      required String recieverMessageToken,
      required String dateTime,
      required String message}) {
    MessageModel mesModel = MessageModel(
        value: message,
        senderId: userModel!.uId,
        recieverId: recieverId,
        dateTime: dateTime,
        recieverMessageToken: recieverMessageToken,
        senderMessageToken: userModel!.messageToken,
        senderName: userModel!.name,
        reciverName: recierverName);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(mesModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).catchError((error) {
      emit(SocialSendMessageError());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(mesModel.toMap())
        .then((value) async {
      await DioHelper.sendMessageToSpaceficPerson(message: mesModel);
      emit(SocialSendMessageSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SocialSendMessageError());
    });
  }

  List<MessageModel> messages = [];

  void getMessages(String recieverId) {
    emit(SocialGetMessagesLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      messages.clear();
      for (var element in event.docs) {
        messages.add(MessageModel.fromMap(element.data()));
      }
      emit(SocialGetMessagesSuccess());
    });
  }

  PostModel findPostById(String postId) {
    return posts.firstWhere((element) => element.postId == postId);
  }

  Future logOut() async {
    FirebaseAuth.instance.signOut().then((value) async {
      CashHelper.clearKey(key: 'uId');

      emit(SocialLogOutSuccess());
      currentIndex = 0;
    });
  }
}
