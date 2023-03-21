import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/views/home/notes/subject_notes.dart';

class SubjectsMenuItem extends StatelessWidget {
  SubjectsMenuItem({super.key, required this.subject});

  String subject;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Get.width / 30),
      child: InkWell(
        onTap: () {
          Get.to(SubjectNotes(subjectName: subject));
        },
        child: Container(
          height: Get.height / 10,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(11)),
          child: Padding(
            padding:
                EdgeInsets.only(left: Get.width / 25, right: Get.width / 25),
            child: Center(
              child: Text(
                subject,
                style: TextStyle(
                    color: Colors.grey.shade600, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
