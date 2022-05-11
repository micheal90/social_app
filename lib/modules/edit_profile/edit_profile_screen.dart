
import 'dart:io';

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/cubit/social_cubit.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/widgets/default_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bioController.dispose();
    phoneController.dispose();
  }

  void update() {
    SocialCubit.get(context).updateUserData(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        bio: bioController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            var user = SocialCubit.get(context).userModel;
            var profileImage = SocialCubit.get(context).profileImage;
            var coverImage = SocialCubit.get(context).coverImage;
            nameController.text = user!.name;
            bioController.text = user.bio;
            phoneController.text = user.phone;

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 230,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: 180,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                            ),
                            child: coverImage != null
                                ? kIsWeb
                                    ? Image.network(
                                        coverImage.path,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(coverImage.path),
                                        fit: BoxFit.cover,
                                      )
                                : Image.network(
                                    user.cover,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            backgroundColor: KPrimaryColor,
                            child: IconButton(
                                onPressed: () =>
                                    SocialCubit.get(context).pickCover(),
                                icon: const Icon(Icons.camera_alt_outlined)),
                          ),
                        ),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 62,
                              backgroundColor: KBackgroungColor,
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                height: 120,
                                width: double.infinity,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: profileImage != null
                                    ? kIsWeb
                                        ? Image.network(
                                            profileImage.path,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            File(profileImage.path),
                                            fit: BoxFit.cover,
                                          )
                                    : Image.network(
                                        user.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: CircleAvatar(
                                backgroundColor: KPrimaryColor,
                                child: IconButton(
                                    onPressed: () =>
                                        SocialCubit.get(context).pickImage(),
                                    icon: const Icon(Icons.camera_alt_outlined)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                
                                DefaultButton(
                                    text: 'Update Profile',
                                    onPressed: () => SocialCubit.get(context)
                                        .uploadProfileImage()),
                                         if (state is SocialUploadProfileImageLoading)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                        if (state is SocialUploadProfileImageLoading)
                                  const LinearProgressIndicator(),
                               
                              ],
                            ),
                          ),
                        if (SocialCubit.get(context).profileImage != null &&
                      SocialCubit.get(context).coverImage != null)
                          const SizedBox(
                            width: 20,
                          ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                
                                DefaultButton(
                                    text: 'Update Cover',
                                    onPressed: () => SocialCubit.get(context)
                                        .uploadCoverImage()),
                                        if (state is SocialUploadCoverImageLoading)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                        if (state is SocialUploadCoverImageLoading)
                                  const LinearProgressIndicator(),
                                
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    onChanged: (String value) {
                      print(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Name must be entered';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    onChanged: (String value) {
                      print(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Bio',
                      prefixIcon: Icon(
                        Icons.info,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Bio must be entered';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    onChanged: (String value) {
                      print(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Phone must be entered';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BuildCondition(
                    condition: state is SocialUpdateUserDataLoading,
                    fallback: (context) =>
                        DefaultButton(text: 'Update', onPressed: update,width: double.infinity,),
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
