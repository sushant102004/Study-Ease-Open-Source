import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';

class CustomButtonWithIcon extends StatelessWidget {
  CustomButtonWithIcon(
      {Key? key,
      required this.constants,
      required this.onTap,
      required this.icon,
      required this.height,
      required this.width})
      : super(key: key);

  final Constants constants;
  void Function()? onTap;
  IconData icon;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: constants.themeColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Icon(icon, color: Colors.white,),
        ),
      ),
    );
  }
}
