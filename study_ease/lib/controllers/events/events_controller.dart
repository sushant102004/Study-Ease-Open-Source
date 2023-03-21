import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_ease/controllers/dialogs/dialogs_controller.dart';
import 'package:study_ease/models/events/events_model.dart';

class EventsController extends GetxController {
  String eventsAPIBaseURL = 'http://139.59.42.124:3000/api/v1/events';
  Future<dynamic> getAllEvents() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('authToken');

    Map<String, String> authorizedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $authToken'
    };

    var response =
        await http.get(Uri.parse(eventsAPIBaseURL), headers: authorizedHeaders);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return EventsModel.fromJson(data);
    }
  }
}
