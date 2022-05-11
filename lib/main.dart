import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/cubit/social_cubit.dart';
import 'package:social_app/layout/home_layout/home_layout.dart';
import 'package:social_app/modules/login/login.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/services/local/cash_helper.dart';
import 'package:social_app/shared/services/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();
   uId = CashHelper.getData(key: 'uId');
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: KBackgroungColor,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              backgroundColor: KBackgroungColor,
              actionsIconTheme: IconThemeData(color: Colors.black),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: KPrimaryColor,
                selectedItemColor: Colors.amber,
                unselectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed)),
        home: uId == null ? LogInScreen() : const HomeLayout(),
      ),
    );
  }
}
