import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/controllers/dialogs/dialogs_controller.dart';
import 'package:study_ease/views/widgets/secondary_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetails extends StatefulWidget {
  EventDetails(
      {super.key,
      required this.image,
      required this.title,
      required this.date,
      required this.time,
      required this.additionalInformation,
      required this.hostedBy,
      required this.link});

  String image;
  String title;
  String date;
  String time;
  String additionalInformation;
  String hostedBy;
  String link;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final constants = Get.put(Constants());
  final dialogsController = Get.put(DialogsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.only(
            top: Get.height / 40, left: Get.width / 25, right: Get.width / 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height / 35),
            SecondaryAppBar(constants: constants, title: 'Event Details'),
            SizedBox(height: Get.height / 35),
            Container(
              width: Get.width / 1.08,
              height: Get.height / 4,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height / 30),
                  SizedBox(
                    width: Get.width / 1.12,
                    child: Text(widget.title,
                        style: TextStyle(
                            color: constants.textColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(height: Get.height / 30),
                  // Date & Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Date Panel
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date',
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          SizedBox(height: Get.height / 50),
                          Container(
                            width: Get.width / 3,
                            height: Get.height / 18,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                widget.date,
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Time Panel
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Time',
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          SizedBox(height: Get.height / 50),
                          Container(
                            width: Get.width / 3,
                            height: Get.height / 18,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                widget.time,
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: Get.height / 30),
                  Text('Additional Information: -',
                      style: TextStyle(
                          color: constants.textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 17)),

                  SizedBox(height: Get.height / 50),
                  Text(
                    widget.additionalInformation,
                    style: TextStyle(
                        color: Colors.grey.shade700, fontSize: 14, height: 1.5),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: Get.height / 30),
                  Text('Hosted By: -',
                      style: TextStyle(
                          color: constants.textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 17)),

                  SizedBox(height: Get.height / 50),
                  Text(widget.hostedBy,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          height: 1.5)),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: InkWell(
                onTap: () async {
                  final Uri url = Uri.parse(
                      widget.link);

                  if (!await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    dialogsController.showErrorDialog(
                        'Error', 'Unable to join event.');
                  }
                },
                child: Container(
                  width: Get.width / 1.12,
                  height: Get.height / 17,
                  decoration: BoxDecoration(
                      color: constants.themeColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Join',
                      style: TextStyle(
                          color: Colors.grey.shade100,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height / 40)
          ],
        ),
      ),
    );
  }
}
