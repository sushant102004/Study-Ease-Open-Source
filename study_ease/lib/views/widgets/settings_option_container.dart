import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';

class SettingsOptionContainer extends StatelessWidget {
  SettingsOptionContainer(
      {super.key,
      required this.constants,
      required this.title,
      required this.onTap,
      required this.icon});

  final Constants constants;
  String title;
  Function() onTap;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey.shade800, fontSize: 18),
              ),
              Icon(
                icon,
                color: Colors.grey.shade800,
                size: 24,
              )
            ],
          ),
        ),
        Divider(thickness: 1.5, height: Get.height / 30)
      ],
    );
  }
}
