import 'package:flutter/material.dart';
import 'package:social_app/shared/constants.dart';


class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
  }) : super(key: key);
  final String text;
  final double? width;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: KPrimaryColor),
      child: MaterialButton(
        height: 40,
        onPressed: onPressed,
        child: Text(
          text,
          style:const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
