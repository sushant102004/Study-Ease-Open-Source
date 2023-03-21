import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/auth/auth_controller.dart';
import 'package:study_ease/views/widgets/custom_button.dart';
import 'package:study_ease/views/widgets/input_widget.dart';

class OTPVerify extends StatefulWidget {
  const OTPVerify({super.key});

  @override
  State<OTPVerify> createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final constants = Get.put(Constants());
    TextEditingController otpController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          alignment: Alignment.center,
          // height: Get.height,
          // width: Get.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              SizedBox(height: Get.height / 15),
              SvgPicture.asset('assets/images/Logo.svg',
                  height: Get.height / 12.5),
              SizedBox(height: Get.height / 60),
              Text('Study Ease',
                  style: TextStyle(
                      color: constants.textColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: Get.height / 10),
              Text('Enter OTP',
                  style: TextStyle(
                      color: constants.textColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: Get.height / 15),
              Text('We had sent an OTP to \nthe mail address that you entered.',
                  style: TextStyle(color: constants.textColor, fontSize: 18),
                  textAlign: TextAlign.center),
              SizedBox(height: Get.height / 25),
              InputWidget(
                  constants: constants,
                  title: 'OTP',
                  hintText: 'eg: 8734',
                  controller: otpController,
                  isObscrue: false),
              SizedBox(height: Get.height / 20),
              CustomButton(
                  constants: constants,
                  title: 'Verify',
                  width: Get.width / 3.2,
                  height: Get.height / 18,
                  onTap: () {
                    authController.verifyOTP(otpController.text);
                  }),
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
