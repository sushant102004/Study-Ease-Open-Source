import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/dialogs/dialogs_controller.dart';
import 'package:study_ease/models/notes/notes_model.dart';
import 'package:study_ease/views/widgets/custom_button_with_icon.dart';
import 'package:study_ease/views/widgets/searchResultModal.dart';
import 'package:http/http.dart' as http;

class PrimaryAppBar extends StatefulWidget {
  const PrimaryAppBar({super.key});

  @override
  State<PrimaryAppBar> createState() => _PrimaryAppBarState();
}

class _PrimaryAppBarState extends State<PrimaryAppBar> {
  final constants = Get.put(Constants());
  TextEditingController searchController = TextEditingController();
  final dialogsController = Get.put(DialogsController());

  String notesAPIBaseURL = 'http://139.59.42.124:3000/api/v1/notes';

  @override
  Widget build(BuildContext context) {
    return Column(
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
            // Search Icon
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    Get.dialog(Dialog(
                      insetPadding: EdgeInsets.all(Get.width / 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Get.width / 40)),
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
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    var authToken =
                                        prefs.getString('authToken');

                                    Map<String, String> authorizedHeaders = {
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
                  icon: Icon(Icons.cloud_upload_outlined,
                      color: constants.textColor, size: Get.width / 16),
                  padding: EdgeInsets.only(right: Get.width / 70),
                  constraints: const BoxConstraints(),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
