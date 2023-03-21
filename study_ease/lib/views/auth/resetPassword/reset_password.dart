import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/auth/auth_controller.dart';
import 'package:study_ease/views/widgets/custom_button.dart';
import 'package:study_ease/views/widgets/input_widget.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final constants = Get.put(Constants());
  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          // height: Get.height,
          // width: Get.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              SizedBox(height: Get.height / 10),
              SvgPicture.asset('assets/images/Logo.svg',
                  height: Get.height / 12.5),
              SizedBox(height: Get.height / 60),
              Text('Study Ease',
                  style: TextStyle(
                      color: constants.textColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: Get.height / 10),
              Text('Reset Password',
                  style: TextStyle(
                      color: constants.textColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: Get.height / 15),
              InputWidget(
                constants: constants,
                title: 'OTP',
                isObscrue: false,
                hintText: 'eg: 4765',
                controller: otpController,
              ),
              SizedBox(height: Get.height / 30),
              InputWidget(
                constants: constants,
                title: 'New Password',
                isObscrue: true,
                hintText: 'eg: aStrong@Password#',
                controller: newPasswordController,
              ),
              SizedBox(height: Get.height / 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          constants: constants,
                          title: 'Reset',
                          width: Get.width / 3.2,
                          height: Get.height / 18,
                          onTap: () {
                            authController.resetPassword(
                                otpController.text.toString().trim(),
                                newPasswordController.text.toString().trim());
                          }),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom))
            ],
          ),
        ),
      ),
    );
  }
}
