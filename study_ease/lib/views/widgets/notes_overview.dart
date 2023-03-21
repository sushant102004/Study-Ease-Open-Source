import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/dialogs/dialogs_controller.dart';
import 'package:study_ease/controllers/notes/notes_controller.dart';
import 'package:study_ease/models/notes/notes_model.dart';
import 'package:study_ease/views/home/notes/notes_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

Future<dynamic> notesOverview(
    BuildContext context, NotesModel notes, int index) {
  final constants = Get.put(Constants());
  final notesController = Get.put(NotesController());
  final dialogsController = Get.put(DialogsController());

  // notesController.incrementNotesViews(notes.notes[index].id);
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      builder: (builder) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width / 15, vertical: Get.height / 50),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notes.notes[index].title,
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: Get.height / 80),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: notes.notes[index].id));
                      Fluttertoast.showToast(msg: 'Id copied to clipboard');
                    },
                    child: Text(
                      'id: ${notes.notes[index].id}',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(height: Get.height / 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.person, color: Colors.grey.shade600, size: 12),
                      SizedBox(width: Get.width / 60),
                      Text(notes.notes[index].uploadedBy.name,
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.normal,
                              fontSize: 12)),
                      SizedBox(width: Get.width / 20),
                      Icon(Icons.remove_red_eye,
                          color: Colors.grey.shade600, size: 12),
                      SizedBox(width: Get.width / 60),
                      Text(notes.notes[index].views.toString(),
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.normal,
                              fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: Get.height / 30),
                  Text(
                    notes.notes[index].description,
                    style: TextStyle(fontSize: 17, color: Colors.grey.shade800),
                  ),
                  SizedBox(height: Get.height / 20),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          notesController
                              .incrementNotesViews(notes.notes[index].id)
                              .then((value) => {
                                    Get.to(NotesView(
                                      appBarTitle: notes.notes[index].title,
                                      downloadLink:
                                          notes.notes[index].downloadLink,
                                    ))
                                  });
                        },
                        child: Container(
                          width: Get.width / 3.1,
                          height: Get.height / 20,
                          decoration: BoxDecoration(
                              color: constants.themeColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text('Study',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width / 50),
                      InkWell(
                        onTap: () async {
                          final Uri url =
                              Uri.parse('https://forms.gle/hc2R96Gyjdpxo2aR9');
                          if (!await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          } else {
                            dialogsController.showErrorDialog(
                                'Error', 'Unable to open this page.');
                          }
                        },
                        child: Container(
                          width: Get.width / 3.1,
                          height: Get.height / 20,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 231, 61, 55),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text('Report',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        );
      });
}
