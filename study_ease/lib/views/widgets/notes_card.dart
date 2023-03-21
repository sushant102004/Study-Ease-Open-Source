import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'dart:math';

class NotesCard extends StatelessWidget {
  NotesCard(
      {super.key,
      required this.constants,
      required this.title,
      required this.shortDescription,
      required this.color,
      required this.onTap,
      required this.uploadedBy,
      required this.views,
      required this.subject});

  final Constants constants;
  String title;
  String shortDescription;
  String uploadedBy;
  Color color;
  int views;
  String subject;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    List colors = [
      constants.BlueSubjectColor,
      constants.GreenSubjectColor,
      constants.RedSubjectColor,
      constants.BrownSubjectColor,
      Colors.orange
    ];

    Random random = new Random();

    return Padding(
      padding: EdgeInsets.all(Get.width / 60),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: Get.height / 7,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade500, blurRadius: 1)
              ]),
          child: Row(
            children: [
              SizedBox(width: Get.width / 80),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Get.width / 4,
                  height: Get.height / 9,
                  decoration: BoxDecoration(
                      color: (subject == 'DSA' ||
                              subject == 'Python' ||
                              subject == 'COA' ||
                              subject == 'Physics' || subject == 'AM')
                          ? constants.RedSubjectColor
                          : (subject == 'Java' ||
                                  subject == 'SE' ||
                                  subject == 'Math' ||
                                  subject == 'BEE' || subject == 'MP')
                              ? constants.GreenSubjectColor
                              : (subject == 'BEE' ||
                                      subject == 'C++' ||
                                      subject == 'DAA' ||
                                      subject == 'Math' || subject == 'Bio')
                                  ? constants.BlueSubjectColor
                                  : (subject == 'C' ||
                                          subject == 'OS' ||
                                          subject == 'CN' ||
                                          subject == 'EVS')
                                      ? constants.BrownSubjectColor
                                      : color,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      subject,
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade100),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Get.width / 100),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height / 55),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width / 1.9,
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      // SizedBox(width: Get.width / 8),
                    ],
                  ),
                  SizedBox(height: Get.width / 90),
                  SizedBox(
                      width: Get.width / 1.75,
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        shortDescription,
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      )),
                  SizedBox(height: Get.height / 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.person, color: Colors.grey.shade600, size: 12),
                      SizedBox(width: Get.width / 60),
                      Text(uploadedBy,
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.normal,
                              fontSize: 12)),
                      SizedBox(width: Get.width / 20),
                      Icon(Icons.remove_red_eye,
                          color: Colors.grey.shade600, size: 12),
                      SizedBox(width: Get.width / 60),
                      Text(views.toString(),
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.normal,
                              fontSize: 12)),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
