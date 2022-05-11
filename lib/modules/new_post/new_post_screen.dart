
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/cubit/social_cubit.dart';
import 'package:social_app/shared/constants.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  var textController = TextEditingController();
  var tagsController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<dynamic> tagsFun(BuildContext context) {
      return showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
          builder: (context) => Padding(
                padding: EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: tagsController,
                        minLines: 1,
                        maxLines: 5,
                        decoration: const InputDecoration(
                            hintText: 'Write tags', border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: OutlinedButton(
                          onPressed: () {
                            SocialCubit.get(context)
                                .addTag(tagsController.text);

                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Add Tags',
                            style: TextStyle(fontSize: 18),
                          )),
                    )
                  ],
                ),
              ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              SocialCubit.get(context).removeTagsList();
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          TextButton(
              onPressed: () {
                if (SocialCubit.get(context).postImage == null) {
                  SocialCubit.get(context).updatePostData(
                      dateTime: DateTime.now().toString(),
                      text: textController.text.trim());
                } else {
                  SocialCubit.get(context).uploadPostImage(
                      dateTime: DateTime.now().toString(),
                      text: textController.text.trim());
                }
                Navigator.pop(context);
              },
              child: const Text(
                'Post',
                style: TextStyle(fontSize: 18),
              ))
        ],
      ),
      body: BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var user = SocialCubit.get(context).userModel;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                if (state is SocialUpdatePostLoading)
                  const LinearProgressIndicator(),
                if (state is SocialUpdatePostLoading)
                  const SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user!.imageUrl),
                      radius: 24,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        user.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: TextFormField(
                  controller: textController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: 'What is in your mind ....',
                    border: InputBorder.none,
                  ),
                )),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: 180,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                            ),
                            child: kIsWeb
                                ? Image.file(
                                    File(SocialCubit.get(context)
                                        .postImage!
                                        .path),
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    SocialCubit.get(context).postImage!)),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          backgroundColor: KPrimaryColor,
                          child: IconButton(
                              onPressed: () =>
                                  SocialCubit.get(context).removePostImage(),
                              icon: const Icon(Icons.close)),
                        ),
                      ),
                    ],
                  ),
                if (SocialCubit.get(context).tags.isNotEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(top: 8),
                      child: SizedBox(
                        width: double.infinity,
                        child: Wrap(
                            spacing: 5,
                            children: List.generate(
                                SocialCubit.get(context).tags.length,
                                (index) => Text(
                                      '#${SocialCubit.get(context).tags[index]}',
                                      style:
                                          const TextStyle(color: KPrimaryColor),
                                    ))),
                      ),
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                          onPressed: () {
                            SocialCubit.get(context).pickPostImage();
                          },
                          icon: const Icon(Icons.image_outlined),
                          label: const Text('Add Photo')),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextButton.icon(
                          onPressed: () => tagsFun(context),
                          icon: const Icon(Icons.tag),
                          label: const Text('Tags')),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
