import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';

class DialogsController extends GetxController {
  final constants = Get.put(Constants());

  showLoadingDialog([String? title]) {
    Get.defaultDialog(
        title: title ?? 'Loading...',
        content: CircularProgressIndicator(color: constants.themeColor),
        titleStyle: TextStyle(color: constants.textColor, fontFamily: 'Lexend'),
        titlePadding: const EdgeInsets.all(16),
        barrierDismissible: false);
  }

  hideDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  showErrorDialog([String? title, String? message, Function()? onTap]) {
    Get.defaultDialog(
      title: title ?? 'Something went wrong!',
      middleText: message ??
          'There was some problem while processing your request. Please mail us details about this issue at support@studyease.tech',
      titlePadding: const EdgeInsets.all(16),
      contentPadding:
          const EdgeInsets.only(bottom: 26, top: 8, left: 8, right: 8),
      cancel: InkWell(
        onTap: onTap ??
            () {
              Get.back();
            },
        child: Container(
          width: Get.width / 4,
          height: Get.height / 25,
          decoration: BoxDecoration(
              color: Colors.redAccent, borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Text('Okay',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }
}
