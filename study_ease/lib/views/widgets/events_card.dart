import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';
import 'package:study_ease/views/home/events/events_details.dart';

class EventCard extends StatelessWidget {
  EventCard({
    super.key,
    required this.title,
    required this.time,
    required this.date,
    required this.image,
    required this.hostedBy,
    required this.additionalInformation,
    required this.link,
  });

  String title;
  String time;
  String date;
  String image;
  String hostedBy;
  String additionalInformation;
  String link;

  final constants = Get.put(Constants());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Get.width / 40),
      child: InkWell(
        onTap: () {
          Get.to(EventDetails(
            image: image,
            title: title,
            date: date,
            time: time,
            additionalInformation: additionalInformation,
            hostedBy: hostedBy,
            link: link,
          ));
        },
        child: Container(
          width: Get.width / 1.6,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 2),
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                width: double.infinity,
                height: Get.height / 5,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13)),
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Get.height / 70,
                    bottom: Get.height / 100,
                    left: Get.height / 70,
                    right: Get.height / 70),
                child: Text(
                  title,
                  style: TextStyle(
                      color: constants.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
