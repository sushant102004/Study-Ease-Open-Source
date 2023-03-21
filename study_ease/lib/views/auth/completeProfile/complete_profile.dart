import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/auth/auth_controller.dart';
import 'package:study_ease/views/widgets/custom_button.dart';
import 'package:study_ease/views/widgets/input_widget.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final constants = Get.put(Constants());

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController collegeController = TextEditingController();

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          // width: Get.width,
          // height: Get.height,
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
              Text('Complete Profile 💻',
                  style: TextStyle(
                      color: constants.textColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: Get.height / 15),
              InputWidget(
                constants: constants,
                title: 'Name',
                hintText: 'eg: Sushant Dhiman',
                isObscrue: false,
                controller: nameController,
              ),
              SizedBox(height: Get.height / 35),
              InputWidget(
                constants: constants,
                title: 'Phone Number',
                isObscrue: false,
                hintText: 'eg: XXXXXXXXX',
                controller: phoneNumberController,
              ),
              SizedBox(height: Get.height / 35),
              InputWidget(
                constants: constants,
                title: 'College / University',
                isObscrue: false,
                hintText: 'eg: MMEC',
                controller: collegeController,
              ),
              SizedBox(height: Get.height / 30),
              Padding(
                padding: EdgeInsets.only(left: Get.width / 11),
                child: Row(
                  children: [
                    CustomButton(
                        constants: constants,
                        title: 'Finish',
                        width: Get.width / 3.2,
                        height: Get.height / 18,
                        onTap: () {
                          authController.completeProfile(
                              nameController.text.toString().trim(),
                              phoneNumberController.text.toString().trim(),
                              collegeController.text.toString().trim());
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
