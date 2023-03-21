import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/auth/auth_controller.dart';
import 'package:study_ease/views/widgets/custom_button.dart';
import 'package:study_ease/views/widgets/input_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final constants = Get.put(Constants());
    final authController = Get.put(AuthController());

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
              Text('Welcome Back🔒',
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
                  isObscrue: false),
              SizedBox(height: Get.height / 30),
              InputWidget(
                  constants: constants,
                  title: 'Password',
                  hintText: 'eg: aStrong#Password',
                  controller: passwordController,
                  isObscrue: true),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(right: Get.width / 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('forgotPassword');
                      },
                      child: Text('Forgot Password?',
                          style: TextStyle(color: constants.themeColor)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height / 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          constants: constants,
                          title: 'Login',
                          width: Get.width / 3.2,
                          height: Get.height / 18,
                          onTap: () {
                            authController.login(
                                emailController.text.toString().trim(),
                                passwordController.text.toString().trim());
                          }),
                      InkWell(
                          onTap: () {
                            Get.toNamed('createAccount');
                          },
                          child: const Text('Create Account',
                              style: TextStyle(fontSize: 17)))
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
