import 'package:buildcondition/buildcondition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'package:social_app/layout/home_layout/cubit/social_cubit.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/constants.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final newMessage = TextEditingController();
  late final UserModel user;
  void sendMessage(context, user) {
    if (newMessage.text.isNotEmpty) {
      SocialCubit.get(context).sendMessage(
          recieverId: user.uId,
          recierverName: user.name,
          recieverMessageToken: user.messageToken,
          dateTime: DateTime.now().toString(),
          message: newMessage.text.trim());
      newMessage.text = '';
    }
  }

  @override
  void initState() {
    super.initState();
    user = SocialCubit.get(context).findUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(user.uId);
      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.imageUrl),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(user.name),
                ],
              ),
              // actions: [
              //   IconButton(
              //       onPressed: () {}, icon: const Icon(Icons.notifications_active)),
              //   IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              // ],
            ),
            body: BuildCondition(
              condition: state is! SocialGetMessagesLoading,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                      //controller: _controller,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: SocialCubit.get(context).messages.length,
                      itemBuilder: (context, index) {
                        var message = SocialCubit.get(context).messages[index];
                        if (message.senderId ==
                            SocialCubit.get(context).userModel!.uId) {
                          return MyMessage(text: message.value);
                        } else {
                          return OtherMessage(text: message.value);
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 10,
                      ),
                    )),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: newMessage,
                              decoration: const InputDecoration(
                                hintText: 'Write tour message here...',
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (_) =>
                                  sendMessage(context, user),
                            ),
                          ),
                          IconButton(
                              onPressed: () => sendMessage(context, user),
                              icon: const Icon(
                                Icons.send,
                                color: KPrimaryColor,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

class OtherMessage extends StatelessWidget {
  const OtherMessage({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: KPrimaryColor.withOpacity(0.2),
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(8),
              bottomStart: Radius.circular(8),
              topStart: Radius.circular(8),
            )),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class MyMessage extends StatelessWidget {
  const MyMessage({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.amber[300],
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(8),
              bottomEnd: Radius.circular(8),
              topStart: Radius.circular(8),
            )),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
