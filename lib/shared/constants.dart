import 'package:flutter/material.dart';

const Color KPrimaryColor = Colors.deepPurple;
const Color KBackgroungColor = Color(0xfff7f6f2);
String? uId;
String? messageToken;
const String apiKey = "AIzaSyBamqh9BZBKexIqTWRANhTqet1U0p7-jaI";
const String messageApiKey =
    "key=AAAA6tWi60A:APA91bG-693wNfTYZHGXe6hCT-lkPxe1RvGci1pcJDLdmc6enHDfQ30c6QnKmIjQH5zyztjLhorcmo8r2U8uN5wVvnXpbqeC-WJQtQaeGtvMyKYUgoYSLKeQPG2RLnYiTya567onY__j";
void navigateTo(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}

void navigateAndFinish(BuildContext context, Widget screen) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => screen));
}
