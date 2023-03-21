import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/auth/auth_controller.dart';
import 'package:study_ease/views/widgets/custom_button.dart';

Padding editProfileCard(
    TextEditingController nameController,
    TextEditingController collegeController,
    String userName,
    String userCollege) {
  final constants = Get.put(Constants());
  final authController = Get.put(AuthController());
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: Get.width / 13, vertical: Get.height / 40),
    child: Wrap(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: Get.height / 25),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                          color: constants.textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: Get.height / 60),
                Container(
                  width: double.infinity,
                  height: Get.height / 17,
                  decoration: BoxDecoration(
                      color: constants.inputBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: constants.inputStrokeColor)),
                  child: TextFormField(
                    controller: nameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: userName,
                      hintStyle: TextStyle(
                          color: constants.inputHintTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      contentPadding: const EdgeInsets.all(14),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: Get.height / 50),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'College',
                      style: TextStyle(
                          color: constants.textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: Get.height / 60),
                Container(
                  width: double.infinity,
                  height: Get.height / 17,
                  decoration: BoxDecoration(
                      color: constants.inputBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: constants.inputStrokeColor)),
                  child: TextFormField(
                    controller: collegeController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: userCollege,
                      hintStyle: TextStyle(
                          color: constants.inputHintTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      contentPadding: const EdgeInsets.all(14),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height / 30),
            CustomButton(
                constants: constants,
                title: 'Update',
                width: Get.width / 3.2,
                height: Get.height / 18,
                onTap: () {
                  authController.editProfile(nameController.text.toString(),
                      collegeController.text.toString());
                })
          ],
        )
      ],
    ),
  );
}
