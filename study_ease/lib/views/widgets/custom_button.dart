import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      required this.constants,
      required this.title,
      required this.onTap,
      required this.height,
      required this.width})
      : super(key: key);

  final Constants constants;
  String title;
  void Function()? onTap;
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: Get.width / 3.2,
        // height: Get.height / 18,
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: constants.themeColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
