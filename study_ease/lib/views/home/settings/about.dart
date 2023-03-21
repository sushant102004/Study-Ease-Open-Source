import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/views/widgets/secondary_app_bar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final constants = Get.put(Constants());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            top: Get.height / 40, left: Get.width / 30, right: Get.width / 30),
        child: Column(
          children: [
            SizedBox(height: Get.height / 35),
            SecondaryAppBar(constants: constants, title: 'About Us'),
            SizedBox(height: Get.height / 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Study Ease is developed to provide free study resources for B.Tech, BCA & Engineering Students. \n\nIt allows students to upload their hand-written study notes and other students to quickly search and study from their notes.\n\nThis app will also provide free of cost roadmaps for several technical skills.\n\nThis app is in constant development. In case you notice any bugs please contact us.',
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16,
                        wordSpacing: 1.5,
                        height: 1.5),
                  ),
                  SizedBox(height: Get.height / 30),
                  Text('Contact',
                      style: TextStyle(
                          color: constants.textColor,
                          fontSize: 19,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: Get.height / 50),
                  Text(
                    'support@studyease.tech',
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                  SizedBox(height: Get.height / 30),
                  Text('Website',
                      style: TextStyle(
                          color: constants.textColor,
                          fontSize: 19,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: Get.height / 50),
                  Text(
                    'studyease.tech',
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                  SizedBox(height: Get.height / 30),
                  Text('Publisher',
                      style: TextStyle(
                          color: constants.textColor,
                          fontSize: 19,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: Get.height / 50),
                  Text(
                    'This app is published by Cookie Byte Apps.',
                    style: TextStyle(color: Colors.grey.shade800),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
