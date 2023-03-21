import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/auth/auth_controller.dart';
import 'package:study_ease/controllers/dialogs/dialogs_controller.dart';
import 'package:study_ease/views/home/settings/about.dart';
import 'package:study_ease/views/widgets/custom_button.dart';
import 'package:study_ease/views/widgets/edit_profile_card.dart';
import 'package:study_ease/views/widgets/input_widget.dart';
import 'package:study_ease/views/widgets/settings_option_container.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDataLoaded = false;
  final constants = Get.put(Constants());
  late String userName;
  late String userCollege;

  TextEditingController nameController = TextEditingController();
  TextEditingController collegeController = TextEditingController();

  final authController = Get.put(AuthController());
  final dialogsController = Get.put(DialogsController());

  void getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userName');
    final college = prefs.getString('userCollege');

    setState(() {
      userName = name!;
      userCollege = college!;
      isDataLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: Get.height / 40, left: Get.width / 30, right: Get.width / 30),
        child: isDataLoaded
            ? Column(
                children: [
                  SizedBox(height: Get.height / 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/Logo.svg',
                              width: Get.width / 10),
                          const SizedBox(width: 10),
                          Text(
                            'Study Ease',
                            style: TextStyle(
                                color: constants.textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 26),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              authController.logOut();
                            },
                            icon: Icon(Icons.logout_outlined,
                                color: constants.textColor,
                                size: Get.width / 16),
                            padding: EdgeInsets.only(right: Get.width / 70),
                            constraints: const BoxConstraints(),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: Get.height / 18),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                    child: Column(
                      children: [
                        SettingsOptionContainer(
                            constants: constants,
                            title: 'Edit Profile',
                            icon: Icons.edit_outlined,
                            onTap: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0))),
                                  context: context,
                                  builder: (builder) {
                                    return editProfileCard(
                                        nameController,
                                        collegeController,
                                        userName,
                                        userCollege);
                                  });
                            }),
                        SizedBox(height: Get.height / 70),
                        SettingsOptionContainer(
                            constants: constants,
                            title: 'Join Community',
                            icon: Icons.whatshot_outlined,
                            onTap: () async {
                              final Uri url = Uri.parse(
                                  'https://discord.gg/2FdwPGD528');

                              if (!await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                dialogsController.showErrorDialog(
                                    'Error', 'Unable to open this page.');
                              }
                            }),
                        SizedBox(height: Get.height / 70),
                        SettingsOptionContainer(
                            constants: constants,
                            title: 'Connect With Me',
                            icon: Icons.person_add_alt_1_outlined,
                            onTap: () async {
                              final Uri url = Uri.parse(
                                  'https://linkedin.com/in/sushant102004');
                              if (!await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                dialogsController.showErrorDialog(
                                    'Error', 'Unable to open this page.');
                              }
                            }),
                        SizedBox(height: Get.height / 70),
                        SettingsOptionContainer(
                            constants: constants,
                            title: 'Request notes',
                            icon: Icons.school_outlined,
                            onTap: () async {
                              final Uri url =
                                Uri.parse('https://discord.gg/2EWEY6cBRF');
                            if (!await canLaunchUrl(url)) {
                              await launchUrl(url,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              dialogsController.showErrorDialog(
                                  'Error', 'Unable to open this page.');
                            }
                            }),
                        SizedBox(height: Get.height / 70),
                        SettingsOptionContainer(
                            constants: constants,
                            title: 'About Study Ease',
                            icon: Icons.info_outline,
                            onTap: () async {
                              Get.to(const AboutUs());
                            }),
                        SizedBox(height: Get.height / 2.9),
                        InkWell(
                          onTap: () async {
                            final Uri url =
                                Uri.parse('https://studyease.tech/privacy');
                            if (!await canLaunchUrl(url)) {
                              await launchUrl(url,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              dialogsController.showErrorDialog(
                                  'Error', 'Unable to open this page.');
                            }
                          },
                          child: Text('Privacy Policy',
                              style: TextStyle(color: Colors.grey.shade700)),
                        ),
                        SizedBox(height: Get.height / 100),
                        Text(
                          'Developed With ❤️ By Cookie Byte Apps',
                          style: TextStyle(color: Colors.grey.shade700),
                        )
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(color: constants.themeColor),
              ),
      ),
    );
  }
}
