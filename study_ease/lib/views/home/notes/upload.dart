import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/dialogs/dialogs_controller.dart';
import 'package:study_ease/controllers/notes/notes_controller.dart';
import 'package:study_ease/views/widgets/custom_button.dart';
import 'package:study_ease/views/widgets/input_widget.dart';

class UploadNotes extends StatefulWidget {
  const UploadNotes({super.key});

  @override
  State<UploadNotes> createState() => _UploadNotesState();
}

class _UploadNotesState extends State<UploadNotes> {
  final constants = Get.put(Constants());
  final notesController = Get.put(NotesController());
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // late PlatformFile notes;
  PlatformFile ?notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(
              top: Get.height / 40,
              left: Get.width / 30,
              right: Get.width / 30),
          child: Column(
            children: [
              SizedBox(height: Get.height / 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: Get.height / 20,
                        width: Get.width / 9.5,
                        decoration: BoxDecoration(
                          color: constants.inputBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: constants.themeColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Upload Notes',
                        style: TextStyle(
                            color: constants.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 26),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(Icons.notifications_outlined,
                  //           color: constants.textColor, size: Get.width / 16),
                  //       padding: EdgeInsets.zero,
                  //       constraints: const BoxConstraints(),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              SizedBox(height: Get.height / 20),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Help us to build this community',
                        style: TextStyle(
                            fontSize: 30,
                            height: 1.3,
                            fontWeight: FontWeight.w500,
                            color: constants.textColor,
                            letterSpacing: 1.6)),
                    SizedBox(height: Get.height / 70),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text('• Upload your notes and help others.',
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w400)),
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text('• Get featured on leaderboard.',
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height / 20),
              InputWidget(
                title: 'Title',
                hintText: 'eg: Hoisting in JavaScript',
                isObscrue: false,
                constants: constants,
                controller: titleController,
              ),
              SizedBox(height: Get.height / 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                child: Row(
                  children: [
                    Text(
                      'PDF',
                      style: TextStyle(
                          color: constants.textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height / 60),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                child: InkWell(
                  onTap: () async {
                    try {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                              allowMultiple: false,
                              allowedExtensions: ['pdf'],
                              type: FileType.custom);

                      if (result == null) {
                        return DialogsController().showErrorDialog(
                            'Error', 'Please make sure to pick a file.');
                      }

                      if(result.files.first.size > 10000000){
                        return DialogsController().showErrorDialog('Not allowed', 'Please make sure that file size is less than 10 MB.');
                      }

                      setState(() {
                        notes = result.files.first;
                      });
                    } catch (e) {
                      return DialogsController().showErrorDialog('Error', '$e');
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: Get.height / 17,
                    decoration: BoxDecoration(
                        color: constants.inputBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: constants.inputStrokeColor)),
                    child: Row(
                      children: [
                        const SizedBox(width: 14),
                        Icon(Icons.cloud_upload_outlined,
                            color: constants.inputHintTextColor),
                        const SizedBox(width: 10),
                        Text(notes != null ? notes!.name : 'Pick PDF File',
                            style: TextStyle(
                                color: constants.inputHintTextColor,
                                fontSize: 15,
                                fontWeight: FontWeight.normal))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height / 30),
              InputWidget(
                title: 'Description',
                hintText: 'eg: Theory & Code of Hoisting in JavaScript',
                isObscrue: false,
                constants: constants,
                controller: descriptionController,
              ),
              SizedBox(height: Get.height / 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                child: Row(
                  children: [
                    CustomButton(
                        constants: constants,
                        title: 'Upload',
                        width: Get.width / 3.2,
                        height: Get.height / 18,
                        onTap: () async {
                          if(notes == null){
                            return DialogsController().showErrorDialog('Error', 'Please pick a PDF file only.');
                          }
                          notesController.uploadNotes(titleController.text,
                              descriptionController.text, notes!);
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
