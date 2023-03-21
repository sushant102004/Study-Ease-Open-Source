import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/applovin/applovin_controller.dart';
import 'package:study_ease/controllers/dialogs/dialogs_controller.dart';
import 'package:study_ease/controllers/notes/notes_controller.dart';
import 'package:study_ease/models/notes/notes_model.dart';
import 'package:study_ease/views/widgets/custom_button_with_icon.dart';
import 'package:study_ease/views/widgets/notes_card.dart';
import 'package:study_ease/views/widgets/notes_overview.dart';
import 'package:study_ease/views/widgets/searchResultModal.dart';
import 'package:study_ease/views/widgets/subjects_menu_items.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final constants = Get.put(Constants());
  final notesController = Get.put(NotesController());
  TextEditingController searchController = TextEditingController();
  final dialogsController = Get.put(DialogsController());
  final applovinController = Get.put(ApplovinController());

  String notesAPIBaseURL = 'http://139.59.42.124:3000/api/v1/notes';


  @override
  void initState() {
    super.initState();
    notesController.getAllNotes();
    applovinController.initializeInterstitialAds();
    showAd();
  }

  void showAd() {
    Timer(Duration(seconds: 5), () => {
      applovinController.showIntersitialAd()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: Get.height / 40, left: Get.width / 30, right: Get.width / 30),
        child: Column(
          children: [
            // App Bar
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
                // Search Icon
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        Get.dialog(Dialog(
                          insetPadding: EdgeInsets.all(Get.width / 20),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Get.width / 40)),
                          child: Padding(
                            padding: EdgeInsets.all(Get.width / 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Get.width / 1.45,
                                  height: Get.height / 17,
                                  decoration: BoxDecoration(
                                      color: constants.inputBackgroundColor,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: constants.inputStrokeColor)),
                                  child: TextFormField(
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Topic or Notes Id',
                                      hintStyle: TextStyle(
                                          color: constants.inputHintTextColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                      contentPadding: const EdgeInsets.all(14),
                                    ),
                                  ),
                                ),
                                CustomButtonWithIcon(
                                    constants: constants,
                                    onTap: () async {
                                      // notesController.searchNotes(searchController.text);
                                      if (searchController.text.isEmpty) {
                                        // ignore: void_checks
                                        return dialogsController.showErrorDialog(
                                            'Provide Topic',
                                            'Make sure to provide search topic or notes id.');
                                      } else {
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        var authToken =
                                            prefs.getString('authToken');

                                        Map<String, String> authorizedHeaders =
                                            {
                                          'Content-type': 'application/json',
                                          'Accept': 'application/json',
                                          'authorization': 'Bearer $authToken'
                                        };

                                        dialogsController
                                            .showLoadingDialog('Searching...');

                                        var response = await http.get(
                                            Uri.parse(
                                                '$notesAPIBaseURL/search/${searchController.text}'),
                                            headers: authorizedHeaders);

                                        dialogsController.hideDialog();
                                        var data = jsonDecode(response.body);

                                        if (response.statusCode == 200 &&
                                            data['total'] == 0) {
                                          return dialogsController.showErrorDialog(
                                              'Opps!',
                                              'No study was found for this topic. ');
                                        }

                                        if (response.statusCode == 200) {
                                          NotesModel searchedNotes =
                                              NotesModel.fromJson(data);

                                          // ignore: use_build_context_synchronously
                                          searchedNotesModal(
                                              context, searchedNotes);
                                        } else {
                                          dialogsController.showErrorDialog();
                                        }
                                      }
                                    },
                                    icon: Icons.search,
                                    height: Get.height / 17,
                                    width: Get.width / 8)
                              ],
                            ),
                          ),
                        ));
                      },
                      icon: Icon(Icons.search_outlined,
                          color: constants.textColor, size: Get.width / 16),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    SizedBox(width: Get.width / 15),
                    IconButton(
                      onPressed: () {
                        Get.toNamed('upload');
                      },
                      icon: Icon(Icons.upload_file_outlined,
                          color: constants.textColor, size: Get.width / 16),
                      padding: EdgeInsets.only(right: Get.width / 70),
                      constraints: const BoxConstraints(),
                    )
                  ],
                )
              ],
            ),

            SizedBox(height: Get.height / 25),
            Container(
              alignment: Alignment.center,
              height: Get.height / 25,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SubjectsMenuItem(subject: 'Python'),
                  SubjectsMenuItem(subject: 'Java'),
                  SubjectsMenuItem(subject: 'DSA'),
                  SubjectsMenuItem(subject: 'C'),
                  SubjectsMenuItem(subject: 'C++'),
                  SubjectsMenuItem(subject: 'HTML'),
                  SubjectsMenuItem(subject: 'CSS'),
                  SubjectsMenuItem(subject: 'JavaScript'),
                  SubjectsMenuItem(subject: 'SE'),
                  SubjectsMenuItem(subject: 'COA'),
                  SubjectsMenuItem(subject: 'OS'),
                  SubjectsMenuItem(subject: 'DAA'),
                  SubjectsMenuItem(subject: 'CN'),
                  SubjectsMenuItem(subject: 'DBMS'),
                  SubjectsMenuItem(subject: 'IoT'),
                  SubjectsMenuItem(subject: 'Physics'),
                  SubjectsMenuItem(subject: 'BEE'),
                  SubjectsMenuItem(subject: 'Math'),
                  SubjectsMenuItem(subject: 'EVS'),
                  SubjectsMenuItem(subject: 'AM'),
                  SubjectsMenuItem(subject: 'MP'),
                  SubjectsMenuItem(subject: 'Bio'),
                ],
              ),
            ),

            SizedBox(height: Get.height / 100),

            Obx(() => notesController.areNotesLoaded == true
                ? Expanded(
                    child: FutureBuilder(
                        future: notesController.getAllNotes(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            NotesModel notes = NotesModel(
                                status: snapshot.data!.status,
                                notes: snapshot.data!.notes,
                                total: snapshot.data!.total);

                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: notes.total,
                                scrollDirection: Axis.vertical,
                                itemBuilder: ((context, index) {
                                  return NotesCard(
                                    constants: constants,
                                    title: notes.notes[index].title,
                                    shortDescription:
                                        notes.notes[index].shortDescription,
                                    color: Colors.orange,
                                    uploadedBy:
                                        notes.notes[index].uploadedBy.name,
                                    subject: notes.notes[index].subject,
                                    views: notes.notes[index].views,
                                    onTap: () {
                                      notesOverview(context, notes, index);
                                    },
                                  );
                                }));
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('There was an error.'),
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.only(
                                top: Get.height / 3, left: Get.width / 30),
                            child: Text('Loading'),
                          );
                        }),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: constants.themeColor,
                      ),
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}
