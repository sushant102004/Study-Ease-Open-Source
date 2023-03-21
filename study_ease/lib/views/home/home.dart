import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/auth/auth_controller.dart';
import 'package:study_ease/views/home/dashboard/dashboard.dart';
import 'package:study_ease/views/home/courses/courses.dart';
import 'package:study_ease/views/home/settings/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final authController = Get.put(AuthController());
  final constants = Get.put(Constants());

  final List _pages = [const Dashboard(), const Courses(), const Settings()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: constants.themeColor,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.school_outlined), label: 'Free Courses'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: 'Settings'),
          ],
        ),
        body: _pages[selectedIndex]);
  }
}
