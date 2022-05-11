import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/cubit/social_cubit.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/constants.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        return BuildCondition(
          condition: state is! SocialGetAllUsersLoading,
          fallback: (context) =>const Center(child: CircularProgressIndicator()),
          builder:(context) =>  ListView.separated(
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) =>
                  ChatItem(user: SocialCubit.get(context).users[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: SocialCubit.get(context).users.length),
        );
      },
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>navigateTo(context, ChatDetailsScreen(userId: user.uId)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.imageUrl),
              radius: 24,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              user.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
