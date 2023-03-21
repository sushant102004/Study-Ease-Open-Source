import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';

class SecondaryAppBar extends StatelessWidget {
  SecondaryAppBar({super.key, required this.constants, required this.title});

  final Constants constants;
  String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: Get.height / 20,
          width: Get.width / 9.5,
          decoration: BoxDecoration(
            color: constants.inputBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: constants.themeColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: Get.width / 1.3,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: constants.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 26),
          ),
        ),
      ],
    );
  }
}
