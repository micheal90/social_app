import 'package:flutter/material.dart';

const Color KPrimaryColor = Colors.deepPurple;
const Color KBackgroungColor = Color(0xfff7f6f2);
String?  uId;
void navigateTo(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}
void navigateAndFinish(BuildContext context, Widget screen) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => screen));
}
