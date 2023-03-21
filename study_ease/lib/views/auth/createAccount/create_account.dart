import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/auth/auth_controller.dart';
import 'package:study_ease/views/widgets/input_widget.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final constants = Get.put(Constants());
  final authController = Get.put(AuthController());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              Text('Create Account🚀',
                  style: TextStyle(
                      color: constants.textColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: Get.height / 15),
              InputWidget(
                constants: constants,
                title: 'Email',
                hintText: 'eg: sushant@gmail.com',
                controller: emailController,
                isObscrue: false,
              ),
              SizedBox(height: Get.height / 30),
              InputWidget(
                constants: constants,
                title: 'Password',
                hintText: 'eg: aStrong@Password#',
                controller: passwordController,
                isObscrue: true,
              ),
              SizedBox(height: Get.height / 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          authController.createAccount(
                              emailController.text.toString().toLowerCase(),
                              passwordController.text.toString());
                        },
                        child: Container(
                          width: Get.width / 3.2,
                          height: Get.height / 18,
                          decoration: BoxDecoration(
                              color: constants.themeColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text('Create',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      InkWell(onTap: (){
                        Get.toNamed('login');
                      }, child: const Text('Login', style: TextStyle(fontSize: 17)))
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
