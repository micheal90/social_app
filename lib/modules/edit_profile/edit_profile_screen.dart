import 'dart:io';

import 'package:buildcondition/buildcondition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/cubit/social_cubit.dart';
import 'package:social_app/modules/edit_profile/cubit/editprofilecubit_cubit.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/widgets/default_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

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

            return Column(
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
                                  user!.cover,
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
                                      user!.imageUrl,
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
                TextFormField(
                  initialValue: user!.name,
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
                const SizedBox(height: 15,),
                TextFormField(
                  initialValue: user.bio,
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
                      Icons.person,
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
                BuildCondition(
                  condition: state is SocialLoading,
                  fallback: (context) =>
                      DefaultButton(text: 'Update', onPressed: () {}),
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
