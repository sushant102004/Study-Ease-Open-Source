import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_ease/controllers/dialogs/dialogs_controller.dart';
import 'package:study_ease/models/notes/notes_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:study_ease/views/home/home.dart';

class NotesController extends GetxController {
  RxBool areNotesLoaded = false.obs;
  RxInt totalSearchResult = 0.obs;

  RxList searchedNotes = [].obs;

  String notesAPIBaseURL = 'http://139.59.42.124:3000/api/v1/notes';
  final dialogsController = Get.put(DialogsController());

  Future<dynamic> getAllNotes() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('authToken');

    Map<String, String> authorizedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $authToken'
    };

    var response =
        await http.get(Uri.parse(notesAPIBaseURL), headers: authorizedHeaders);
    var data = jsonDecode(response.body);
    areNotesLoaded.value = true;
    if (response.statusCode == 200) {
      return NotesModel.fromJson(data);
    }
  }

  //////////////////////////////////////////////////////////////////////// Get Subject Notes
  Future<dynamic> getSubjectNotes(String subject) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('authToken');

    Map<String, String> authorizedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $authToken'
    };

    dialogsController.showLoadingDialog();

    var response = await http.get(
        Uri.parse('$notesAPIBaseURL/subject/$subject'),
        headers: authorizedHeaders);

    dialogsController.hideDialog();

    var data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['total'] == 0) {
      dialogsController.showErrorDialog('Opps!',
          'We do not have any study material in this category please check back later. If you have study resources for this category please upload it.');
          
    }

    if (response.statusCode == 200) {
      totalSearchResult.value = data['total'];
      return NotesModel.fromJson(data);
    }
  }

  Future uploadNotes(
      String title, String description, PlatformFile pickedFile) async {
    if (title.isEmpty || description.isEmpty) {
      return dialogsController.showErrorDialog(
          'Provide Details', 'Please enter both title and description.');
    }

    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('authToken');

    Map<String, String> authorizedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $authToken'
    };

    dialogsController.showLoadingDialog();

    var userID = prefs.getString('userID');

    var request =
        http.MultipartRequest('POST', Uri.parse('$notesAPIBaseURL/upload'));

    request.headers.addAll(authorizedHeaders);

    request.files.add(
        await http.MultipartFile.fromPath('notes', pickedFile.path.toString()));

    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['uploadedBy'] = userID!;

    var response = await request.send();
    dialogsController.hideDialog();

    if (response.statusCode == 200) {
      Get.snackbar('Done', 'Notes sent for review.');
      Get.offAll(const Home());
    } else {
      dialogsController.showErrorDialog();
    }
  }

  //////////////////////////////////////////////////////////////////////// Increment Notes
  Future<dynamic> incrementNotesViews(String notesID) async {
    if (notesID.isEmpty) {
      return dialogsController.showErrorDialog();
    }

    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('authToken');

    Map<String, String> authorizedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $authToken'
    };

    var response = await http.post(
        Uri.parse('$notesAPIBaseURL/incremenet-views'),
        headers: authorizedHeaders,
        body: jsonEncode({'notesID': notesID.toString()}));

    if (response.statusCode != 200) {
      return dialogsController.showErrorDialog();
    }
  }
}
