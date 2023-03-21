import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/auth/auth_controller.dart';
import 'package:study_ease/views/widgets/custom_button.dart';
import 'package:study_ease/views/widgets/input_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final constants = Get.put(Constants());

    final authController = Get.put(AuthController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: Get.width / 7.4,
            height: Get.height / 17,
            decoration: BoxDecoration(
                color: constants.inputBackgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios_new,
                      color: constants.themeColor, size: 20)),
            ),
          ),
        ),
      ),
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
              Text('Forgot Password❓',
                  style: TextStyle(
                      color: constants.textColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: Get.height / 15),
              InputWidget(
                constants: constants,
                title: 'Email',
                isObscrue: false,
                hintText: 'eg: sushant@gmail.com',
                controller: emailController,
              ),
              SizedBox(height: Get.height / 30),
              Padding(
                padding: EdgeInsets.only(left: Get.width / 11),
                child: Row(
                  children: [
                    CustomButton(
                        constants: constants,
                        title: 'Next',
                        width: Get.width / 3.2,
                        height: Get.height / 18,
                        onTap: () {
                          authController
                              .forgotPassword(emailController.text.toString());
                        }),
                  ],
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
