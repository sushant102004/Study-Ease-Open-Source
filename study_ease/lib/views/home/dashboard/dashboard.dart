import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/applovin/applovin_controller.dart';
import 'package:study_ease/controllers/events/events_controller.dart';
import 'package:study_ease/controllers/notes/notes_controller.dart';
import 'package:study_ease/models/events/events_model.dart';
import 'package:study_ease/models/notes/notes_model.dart';
import 'package:study_ease/views/home/home.dart';
import 'package:study_ease/views/widgets/events_card.dart';
import 'package:study_ease/views/widgets/notes_card.dart';
import 'package:study_ease/views/widgets/notes_overview.dart';
import 'package:study_ease/views/widgets/primary_appbar.dart';
import 'package:study_ease/views/home/notes/notes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final constants = Get.put(Constants());
  final eventsController = Get.put(EventsController());
  final notesController = Get.put(NotesController());

  final applovinController = Get.put(ApplovinController());

  @override
  void initState() {
    super.initState();
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
        backgroundColor: constants.backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(
              top: Get.height / 40,
              left: Get.width / 30,
              right: Get.width / 30),
          child: Column(
            children: [
              const PrimaryAppBar(),
              SizedBox(
                height: Get.height / 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Events',
                      style: TextStyle(
                          color: constants.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height / 120),
                      child: InkWell(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg:
                                  'This feature will be available in upcoming update.');
                        },
                        child: Text(
                          'See All >',
                          style: TextStyle(
                              color: constants.unfocusedText,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Get.height / 45),
              FutureBuilder(
                  future: eventsController.getAllEvents(),
                  builder: (builder, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                          child:
                              Text('There was some error. Please report it.'));
                    }

                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      EventsModel events = EventsModel(
                          status: snapshot.data!.status,
                          events: snapshot.data!.events,
                          total: snapshot.data!.total);

                      if (events.total == 0) {
                        return Center(
                          child: Text('No events happening.',
                              style: TextStyle(color: Colors.grey.shade700)),
                        );
                      }

                      return SizedBox(
                        height: Get.height / 3.4,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.total,
                            itemBuilder: ((context, index) {
                              String? title = events.events![index]!.title;
                              String? image = events.events![index]!.image;
                              String? date = events.events![index]!.date;
                              String? time = events.events![index]!.time;
                              String? additionalInformation =
                                  events.events![index]!.additionalInformation;
                              String? hostedBy =
                                  events.events![index]!.hostedBy;
                              String? link = events.events![index]!.link;

                              return EventCard(
                                title: title ?? 'Server Error',
                                additionalInformation:
                                    additionalInformation ?? 'Server Error',
                                date: date ?? 'Server Error',
                                hostedBy: hostedBy ?? 'Server Error',
                                image: image ?? 'Server Error',
                                link: link ?? 'Server Error',
                                time: time ?? 'Server Error',
                              );
                            })),
                      );
                    }
                    return CircularProgressIndicator(
                        color: constants.themeColor);
                  }),

              // Notes Section
              SizedBox(height: Get.height / 30),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 100,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Latest Notes',
                      style: TextStyle(
                          color: constants.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height / 100),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('notes');
                        },
                        child: Text(
                          'See All >',
                          style: TextStyle(
                              color: constants.unfocusedText,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Expanded(
                child: FutureBuilder(
                    future: notesController.getAllNotes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
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
                                uploadedBy: notes.notes[index].uploadedBy.name,
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
            ],
          ),
        ));
  }
}
