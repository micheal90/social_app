part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}

class SocialLoading extends SocialState {}

class SocialGetUserSuccess extends SocialState {}

class SocialGetUserError extends SocialState {
  final String error;
  SocialGetUserError({
    required this.error,
  });
}

class SocialChangeBottomNav extends SocialState {}

class SocialCoverImagePickedSuccess extends SocialState {}

class SocialCoverImagePickedError extends SocialState {}

class SocialProfileImagePickedSuccess extends SocialState {}

class SocialProfileImagePickedError extends SocialState {}
