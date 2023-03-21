import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/dialogs/dialogs_controller.dart';
import 'package:study_ease/views/widgets/secondary_app_bar.dart';
import 'package:applovin_max/applovin_max.dart';

class NotesView extends StatefulWidget {
  NotesView({super.key, required this.appBarTitle, required this.downloadLink});

  String appBarTitle;
  String downloadLink;

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  final constants = Get.put(Constants());
  final dialogsController = Get.put(DialogsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: Get.height / 40, left: Get.width / 30, right: Get.width / 30),
        child: Column(
          children: [
            SizedBox(height: Get.height / 35),
            SecondaryAppBar(constants: constants, title: widget.appBarTitle),
            SizedBox(height: Get.height / 15),
            SizedBox(
              width: double.infinity,
              height: Get.height / 1.4,
              child: PDF(
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: true,
                  onError: (error) {
                    dialogsController.showErrorDialog('Error',
                        'There was some problem with the file. Please report it');
                  },
                  onPageError: (error, page) {
                    dialogsController.showErrorDialog('Error',
                        'There was some problem with the file. Please report it');
                  }).fromUrl(widget.downloadLink,
                  placeholder: (progress) {
                    return Center(
                      child: Text('Loading: - $progress %',
                          style: TextStyle(color: Colors.grey.shade800)),
                    );
                  },
                  errorWidget: (error) => const Center(
                          child: Text(
                        'There was some error while loading this file. Please report it.',
                        textAlign: TextAlign.center,
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
