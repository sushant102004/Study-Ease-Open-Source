class EventsModelEvents {
/*
{
  "title": "Compose",
  "image": "https://studyease.sgp1.digitaloceanspaces.com/event-posters/1677578887896.jpg",
  "date": "02-03-2023",
  "time": "4:00PM - 5:00PM",
  "additionalInformation": "Compose Camp is an event in which we will teach you how to make android apps using Jetpack Compose and Kotlin",
  "hostedBy": "Google Developer Student Club - MMDU",
  "isCompleted": false,
  "link": "https://google.com",
  "__v": 0,
  "id": "63fdd28850546eba189db936"
} 
*/

  String? title;
  String? image;
  String? date;
  String? time;
  String? additionalInformation;
  String? hostedBy;
  bool? isCompleted;
  String? link;
  String? id;

  EventsModelEvents({
    this.title,
    this.image,
    this.date,
    this.time,
    this.additionalInformation,
    this.hostedBy,
    this.isCompleted,
    this.link,
    this.id,
  });
  EventsModelEvents.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    image = json['image']?.toString();
    date = json['date']?.toString();
    time = json['time']?.toString();
    additionalInformation = json['additionalInformation']?.toString();
    hostedBy = json['hostedBy']?.toString();
    isCompleted = json['isCompleted'];
    link = json['link']?.toString();
    id = json['id']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    data['date'] = date;
    data['time'] = time;
    data['additionalInformation'] = additionalInformation;
    data['hostedBy'] = hostedBy;
    data['isCompleted'] = isCompleted;
    data['link'] = link;
    data['id'] = id;
    return data;
  }
}

class EventsModel {
/*
{
  "status": "success",
  "events": [
    {
      "title": "Compose",
      "image": "https://studyease.sgp1.digitaloceanspaces.com/event-posters/1677578887896.jpg",
      "date": "02-03-2023",
      "time": "4:00PM - 5:00PM",
      "additionalInformation": "Compose Camp is an event in which we will teach you how to make android apps using Jetpack Compose and Kotlin",
      "hostedBy": "Google Developer Student Club - MMDU",
      "isCompleted": false,
      "link": "https://google.com",
      "__v": 0,
      "id": "63fdd28850546eba189db936"
    }
  ],
  "total": 2
} 
*/

  String? status;
  List<EventsModelEvents?>? events;
  int? total;

  EventsModel({
    this.status,
    this.events,
    this.total,
  });
  EventsModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    if (json['events'] != null) {
      final v = json['events'];
      final arr0 = <EventsModelEvents>[];
      v.forEach((v) {
        arr0.add(EventsModelEvents.fromJson(v));
      });
      events = arr0;
    }
    total = json['total']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (events != null) {
      final v = events;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['events'] = arr0;
    }
    data['total'] = total;
    return data;
  }
}
