part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}

class SocialGetUserLoading extends SocialState {}

class SocialGetUserSuccess extends SocialState {}

class SocialGetUserError extends SocialState {
  final String error;
  SocialGetUserError({
    required this.error,
  });
}

//get all users
class SocialGetAllUsersLoading extends SocialState {}

class SocialGetAllUsersSuccess extends SocialState {}

class SocialGetAllUsersError extends SocialState {
  final String error;
  SocialGetAllUsersError({
    required this.error,
  });
}



class SocialChangeBottomNav extends SocialState {}

class Post extends SocialState {}

class SocialCoverImagePickedSuccess extends SocialState {}

class SocialCoverImagePickedError extends SocialState {}

class SocialProfileImagePickedSuccess extends SocialState {}

class SocialProfileImagePickedError extends SocialState {}

class SocialUploadCoverImageLoading extends SocialState {}

class SocialUploadCoverImageSuccess extends SocialState {}

class SocialUploadCoverImageError extends SocialState {}

class SocialUploadProfileImageLoading extends SocialState {}

class SocialUploadProfileImageSuccess extends SocialState {}

class SocialUploadProfileImageError extends SocialState {}

class SocialUpdateUserDataLoading extends SocialState {}

class SocialUpdateUserDataError extends SocialState {}

//post pick image
class SocialPostImagePickedSuccess extends SocialState {}

class SocialPostImagePickedError extends SocialState {}

class SocialPostImageRemove extends SocialState {}

//upload post image
class SocialUploadPostImageSuccess extends SocialState {}

class SocialUploadPostImageError extends SocialState {}

//update post data
class SocialUpdatePostLoading extends SocialState {}

class SocialUpdatePostSuccess extends SocialState {}

class SocialUpdatePostError extends SocialState {}

//add tags


class SocialAddTagSuccess extends SocialState {}
class SocialRemoveTagsListSuccess extends SocialState {}


//get posts

class SocialGetPostsLoading extends SocialState {}

class SocialGetPostsSuccess extends SocialState {}

class SocialGetPostsError extends SocialState {
  final String error;
  SocialGetPostsError({
    required this.error,
  });
}

//like post
class SocialLikePostSuccess extends SocialState {}

class SocialLikePostError extends SocialState {
  final String error;
  SocialLikePostError({
    required this.error,
  });
}
//comments
class SocialAddCommentToPostSuccess extends SocialState {}

class SocialAddCommentToPostError extends SocialState {
  final String error;
  SocialAddCommentToPostError({
    required this.error,
  });
}

//chats

class SocialSendMessageSuccess extends SocialState {}
class SocialSendMessageError extends SocialState {}
class SocialGetMessagesLoading extends SocialState {}
class SocialGetMessagesSuccess extends SocialState {}


//logOut
class SocialLogOutSuccess extends SocialState {}
class SocialLogOutError extends SocialState {}

