import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:social_app/layout/home_layout/cubit/social_cubit.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/constants.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print(SocialCubit.get(context).posts.length);
        print(SocialCubit.get(context).userModel != null);
//SocialCubit.get(context).posts.isNotEmpty &&
        return BuildCondition(
          condition: SocialCubit.get(context).posts.isNotEmpty &&
              SocialCubit.get(context).userModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   width: double.infinity,
                //   child: Card(
                //     margin: const EdgeInsets.all(8),
                //     elevation: 10,
                //     clipBehavior: Clip.antiAliasWithSaveLayer,
                //     child: Image.network(
                //       'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
                //       fit: BoxFit.cover,
                //       height: 250,
                //       width: double.infinity,
                //     ),
                //   ),
                // ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => PostWidget(
                    post: SocialCubit.get(context).posts[index],
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 8,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PostWidget extends StatelessWidget {
  PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);
  final PostModel post;

  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(post.image),
                    radius: 24,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const FittedBox(
                                  child: Icon(
                                Icons.done,
                                color: Colors.white,
                              )),
                            )
                          ],
                        ),
                        Text(
                          DateFormat.yMd().add_jm()
                              .format(DateTime.parse(post.dateTime)),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 20,
                      ))
                ],
              ),
            ),
            const Divider(),
            Text(post.text),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 8),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                    spacing: 5,
                    children: List.generate(
                        post.tags.length,
                        (index) => InkWell(
                              child: Text(
                                '#${post.tags[index]}',
                                style: const TextStyle(color: KPrimaryColor),
                              ),
                            ))),
              ),
            ),
            if (post.postImage.isNotEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 10),
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 3,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                    post.postImage,
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
              ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              post.likes.isEmpty
                                  ? Icons.favorite_border_rounded
                                  : Icons.favorite,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              post.likes.length.toString(),
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        commentFun(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.textsms_outlined,
                              color: KPrimaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${post.comments.length}',
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      commentFun(context);
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                SocialCubit.get(context).userModel!.imageUrl),
                            radius: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'Write a comment ...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => SocialCubit.get(context).likePost(post.postId),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          post.likes.contains(
                                  SocialCubit.get(context).userModel!.uId)
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Like',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.share_rounded,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Share',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> commentFun(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  top: 8,
                  left: 8,
                  right: 8,
                  bottom: MediaQuery.of(context).viewInsets.bottom+20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: post.comments.length,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(post.comments[index].imageUrl),
                              radius: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.comments[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                post.comments[index].value,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: commentController,
                        minLines: 1,
                        maxLines: 5,
                        decoration: const InputDecoration(
                            hintText: 'Write a comment',
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: OutlinedButton(
                          onPressed: () {
                            SocialCubit.get(context).addComment(
                                post.postId, commentController.text.trim());
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Add Comment',
                            style: TextStyle(fontSize: 18),
                          )),
                    )
                  ],
                ),
              ),
            ));
  }
}
