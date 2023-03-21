import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/notes/notes_controller.dart';
import 'package:study_ease/models/notes/notes_model.dart';
import 'package:study_ease/views/widgets/notes_card.dart';
import 'package:study_ease/views/widgets/notes_overview.dart';
import 'package:study_ease/views/widgets/secondary_app_bar.dart';

class SubjectNotes extends StatefulWidget {
  SubjectNotes({super.key, required this.subjectName});
  String subjectName;

  @override
  State<SubjectNotes> createState() => _SubjectNotesState();
}

class _SubjectNotesState extends State<SubjectNotes> {
  final constants = Get.put(Constants());
  bool areNotesLoaded = false;

  final notesController = Get.put(NotesController());

  @override
  void initState() {
    super.initState();
    areNotesLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: Get.height / 40, left: Get.width / 30, right: Get.width / 30),
        child: Column(
          children: [
            SizedBox(height: Get.height / 35),
            SecondaryAppBar(constants: constants, title: widget.subjectName),
            Expanded(
              child: FutureBuilder(
                  future: notesController.getSubjectNotes(widget.subjectName),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      NotesModel notes = NotesModel(
                        status: snapshot.data!.status,
                        notes: snapshot.data!.notes,
                        total: snapshot.data!.total,
                      );

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: notes.notes.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                NotesCard(
                                  constants: constants,
                                  title: notes.notes[index].title,
                                  shortDescription:
                                      notes.notes[index].shortDescription,
                                  uploadedBy:
                                      notes.notes[index].uploadedBy.name,
                                  subject: notes.notes[index].subject,
                                  views: notes.notes[index].views,
                                  color: Colors.orange,
                                  onTap: () {
                                    notesOverview(context, notes, index);
                                  },
                                )
                              ],
                            );
                          }));
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('There was an error.'),
                      );
                    }
                    return Container();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
