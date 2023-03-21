import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/models/notes/notes_model.dart';
import 'package:study_ease/views/widgets/notes_card.dart';
import 'package:study_ease/views/widgets/notes_overview.dart';

final constants = Get.put(Constants());

Future<dynamic> searchedNotesModal(
    BuildContext context, NotesModel searchedNotes) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Get.width / 30),
              topRight: Radius.circular(Get.width / 30))),
      context: context,
      builder: (builder) {
        return SizedBox(
          width: Get.width,
          height: Get.height / 1.5,
          child: ListView.builder(
              itemCount: searchedNotes.total,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return NotesCard(
                    constants: constants,
                    title: searchedNotes.notes[index].title,
                    shortDescription:
                        searchedNotes.notes[index].shortDescription,
                    color: Colors.orange,
                    onTap: () {
                      notesOverview(context, searchedNotes, index);
                    },
                    uploadedBy: searchedNotes.notes[index].uploadedBy.name,
                    views: searchedNotes.notes[index].views,
                    subject: searchedNotes.notes[index].subject);
              }),
        );
      });
}
