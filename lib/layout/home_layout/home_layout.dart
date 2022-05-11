import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/cubit/social_cubit.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/constants.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_active)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: KPrimaryColor,
            onPressed: () => navigateTo(context, const NewPostScreen()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.post_add),
                Text('Post'),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) => cubit.changeBottomNavIndex(index),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.connect_without_contact), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settingss'),
              ]),
        );
      },
    );
  }
}
