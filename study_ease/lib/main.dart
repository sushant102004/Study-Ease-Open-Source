import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/views/auth/completeProfile/complete_profile.dart';
import 'package:study_ease/views/auth/createAccount/create_account.dart';
import 'package:study_ease/views/auth/forgotPassword/forgot_password.dart';
import 'package:study_ease/views/auth/login/login.dart';
import 'package:study_ease/views/auth/otpVerify/otp_verify.dart';
import 'package:study_ease/views/auth/resetPassword/reset_password.dart';
import 'package:study_ease/views/home/home.dart';
import 'package:study_ease/views/home/notes/notes.dart';
import 'package:study_ease/views/home/notes/upload.dart';
import 'package:study_ease/views/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/createAccount', page: () => const CreateAccount()),
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/otp', page: () => const OTPVerify()),
        GetPage(name: '/completeProfile', page: () => const CompleteProfile()),
        GetPage(name: '/forgotPassword', page: () => const ForgotPassword()),
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/resetPassword', page: () => const ResetPassword()),
        GetPage(name: '/upload', page: () => const UploadNotes()),
        GetPage(name: '/notes', page: () => const Notes())
      ],
      theme: ThemeData(fontFamily: 'Lexend'),
    );
  }
}
