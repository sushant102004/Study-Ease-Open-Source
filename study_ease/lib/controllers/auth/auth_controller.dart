import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_ease/controllers/applovin/applovin_controller.dart';
import 'package:study_ease/controllers/dialogs/dialogs_controller.dart';
import 'package:study_ease/models/user/user_model.dart';
import 'package:restart_app/restart_app.dart';
import 'package:study_ease/views/auth/createAccount/create_account.dart';

Map<String, String> requestHeaders = {
  'Content-type': 'application/json',
  'Accept': 'application/json'
};

class AuthController extends GetxController {
  String usersAPIBaseURL = 'http://139.59.42.124:3000/api/v1/users';

  final dialogsController = Get.put(DialogsController());
  final applovinController = Get.put(ApplovinController());

  Future<dynamic> createAccount(String email, String password) async {
    if (email.isEmpty || !email.isEmail) {
      return dialogsController.showErrorDialog(
          'Incorrect Email', 'Please provide an email address.');
    }

    if (password.isEmpty || password.length < 8) {
      return dialogsController.showErrorDialog('Weak password',
          'Make sure that your password is at least 8 characters.');
    }

    final prefs = await SharedPreferences.getInstance();

    dialogsController.showLoadingDialog();

    var response = await http.post(Uri.parse('$usersAPIBaseURL/sign-up'),
        headers: requestHeaders,
        body: jsonEncode({'email': email, 'password': password}));

    dialogsController.hideDialog();

    // Checking rate limit
    if (response.statusCode == 429) {
      return dialogsController.showErrorDialog('Too many requests',
          'You are sending too many requests to the server. Please try again after 30 minutes.');
    }

    var data = jsonDecode(response.body);

    if (data['message'] == 'Your account has been created successfully.') {
      dialogsController.hideDialog();
      await prefs.setString('authToken', data['token']);
      Get.offAllNamed('otp');
    } else if (data['message'] == 'Duplicate Value.') {
      return dialogsController.showErrorDialog(
          'Duplicate E-mail', 'Email already exists. Please log in instead.');
    } else {
      return dialogsController.showErrorDialog();
    }
  }

  // ---------------------------------------------------------------- OTP Verify
  Future<dynamic> verifyOTP(String enteredOTP) async {
    if (enteredOTP.isEmpty) {
      return dialogsController.showErrorDialog(
          'Empty OTP', 'Make sure to provide an OTP.');
    }

    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('authToken');

    Map<String, String> authorizedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $authToken'
    };

    if (!enteredOTP.isNum) {
      return dialogsController.showErrorDialog(
          'Error', 'Please enter a numeric OTP only.');
    }
    var otp = int.parse(enteredOTP);

    dialogsController.showLoadingDialog();
    var response = await http.post(Uri.parse('$usersAPIBaseURL/verify-otp'),
        headers: authorizedHeaders, body: jsonEncode({'OTP': otp.toInt()}));
    dialogsController.hideDialog();

    var data = jsonDecode(response.body);

    if (data['message'] == 'Your account has been activated.') {
      Get.offAllNamed('completeProfile');
    } else if (data['message'] == 'Invalid OTP') {
      return dialogsController.showErrorDialog(
          data['message'], 'Entered OTP is invalid. Please type carefully.');
    } else if (data['message'] == 'Please enter the OTP.') {
      return dialogsController.showErrorDialog(
          data['message'], 'Entered OTP is invalid. Please type carefully.');
    } else {
      dialogsController.showErrorDialog();
    }
  }

  // ---------------------------------------------------------------- Complete Profile
  Future<dynamic> completeProfile(
      String name, String phoneNumber, String college) async {
    if (name.isEmpty || phoneNumber.isEmpty || college.isEmpty) {
      return dialogsController.showErrorDialog(
          'Error', 'Please make sure to provide correct details.');
    }

    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('authToken');

    Map<String, String> authorizedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $authToken'
    };

    if (!phoneNumber.isNum) {
      return dialogsController.showErrorDialog(
          'Error', 'Please enter a phone number.');
    }

    var phone = int.parse(phoneNumber);

    dialogsController.showLoadingDialog();
    var response = await http.post(
        Uri.parse('$usersAPIBaseURL/complete-profile'),
        headers: authorizedHeaders,
        body: jsonEncode(
            {"name": name, "phoneNumber": phone, "college": college}));
    dialogsController.hideDialog();

    var data = jsonDecode(response.body);
    var statusCode = response.statusCode;

    if (data['message'] == 'Profile completed successfully.') {
      autoLogin();
    } else if (statusCode != 200) {
      dialogsController.showErrorDialog();
    }
  }

  // ---------------------------------------------------------------- Login
  Future<dynamic> login(String email, String password) async {
    if (email.isEmpty || !email.isEmail) {
      return dialogsController.showErrorDialog(
          'Incorrect Email', 'Please provide an email address.');
    }

    if (password.isEmpty || password.length < 8) {
      return dialogsController.showErrorDialog(
          'Invalid Password', 'Please provide an valid password.');
    }

    final prefs = await SharedPreferences.getInstance();
    dialogsController.showLoadingDialog();

    var response = await http.post(Uri.parse('$usersAPIBaseURL/login'),
        headers: requestHeaders,
        body: jsonEncode({'email': email, 'password': password}));

    dialogsController.hideDialog();

    var data = jsonDecode(response.body);

    if (data['status'] == 'Not Found') {
      return dialogsController.showErrorDialog('Not Found',
          'Entered email & password is either wrong or there is no account with these details.');
    } else if (data['account']['accountStatus'] == 'disabled') {
      return dialogsController.showErrorDialog('Account Banned',
          'Your account has been disabled by the system. Contact us for more details.');
    } else if (data['status'] == 'success' &&
        data['message'] == 'You have successfully signed in.') {
      await prefs.setString('authToken', data['token']);
      await prefs.setString('userID', data['account']['id']);
      await prefs.setString('userName', data['account']['name']);
      await prefs.setString('userEmail', data['account']['email']);
      await prefs.setInt('userPhoneNumber', data['account']['phoneNumber']);
      await prefs.setString('userCollege', data['account']['college']);

      Get.offAllNamed('home');
    } else {
      dialogsController.showErrorDialog();
    }
  }

  // ---------------------------------------------------------------- Auto Login
  Future<dynamic> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('authToken');

    Map<String, String> authorizedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $authToken'
    };

    var response = await http.post(Uri.parse('$usersAPIBaseURL/auto-login'),
        headers: authorizedHeaders);

    var data = jsonDecode(response.body);

    if (data['message'] == 'User not found.') {
      return Get.offAllNamed('createAccount');
    } else if (data['account']['accountStatus'] == 'disabled') {
      return dialogsController.showErrorDialog(
          'Account Banned',
          'Your account has been disabled by the system. Contact us for more details.',
          () => {Get.offAllNamed('createAccount')});
    } else if (data['account']['accountStatus'] == 'pending') {
      Get.offAllNamed('otp');
    } else if (data['account']['accountStatus'] == 'pendingCompletion') {
      Get.offAllNamed('completeProfile');
    } else if (data['message'] == 'You have successfully signed in.') {
      await prefs.setString('authToken', data['token']);
      await prefs.setString('userID', data['account']['id']);
      await prefs.setString('userName', data['account']['name']);
      await prefs.setString('userEmail', data['account']['email']);
      await prefs.setInt('userPhoneNumber', data['account']['phoneNumber']);
      await prefs.setString('userCollege', data['account']['college']);
      Get.offAllNamed('home');
    } else {
      Get.offAllNamed('createAccount');
    }
  }

  // ---------------------------------------------------------------- Get User Details
  Future<User> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('authToken');

    Map<String, String> authorizedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $authToken'
    };

    var response = await http.post(Uri.parse('$usersAPIBaseURL/auto-login'),
        headers: authorizedHeaders);

    return User.fromJson(jsonDecode(response.body));
  }

  //  ---------------------------------------------------------------- Forgot Password
  Future<dynamic> forgotPassword(String email) async {
    if (email.isEmpty || !email.isEmail) {
      return dialogsController.showErrorDialog(
          'Incorrect Email', 'Please provide an email address.');
    }

    dialogsController.showLoadingDialog();
    var response = await http.post(
        Uri.parse('$usersAPIBaseURL/forgot-password'),
        headers: requestHeaders,
        body: jsonEncode({'email': email}));
    dialogsController.hideDialog();

    // Checking rate limit
    if (response.statusCode == 429) {
      return dialogsController.showErrorDialog('Too many requests',
          'You are sending too many requests to the server. Please try again after 30 minutes.');
    }

    var data = jsonDecode(response.body);

    if (data['message'] ==
        'An OTP has been created and sent to your email address.') {
      Get.offAllNamed('resetPassword');
    } else if (data['message'] == 'No user found with given email.') {
      return dialogsController.showErrorDialog('Error',
          'No user found with given email. Make sure you entered correct email.');
    } else if (data['message'] == 'Account disabled.') {
      return dialogsController.showErrorDialog(
          'Account Disabled', 'Your account has been disabled.');
    } else {
      dialogsController.showErrorDialog();
    }
  }

  //  ---------------------------------------------------------------- Reset Password
  Future<dynamic> resetPassword(String enteredOTP, String newPassword) async {
    if (enteredOTP.isEmpty) {
      return dialogsController.showErrorDialog(
          'Error', 'OTP is empty. Make sure you enter an OTP.');
    }

    if (newPassword.isEmpty) {
      return dialogsController.showErrorDialog('Error',
          'New password is empty. Make sure you enter a new password.');
    }

    var otp = int.parse(enteredOTP);

    dialogsController.showLoadingDialog();
    var response = await http.post(Uri.parse('$usersAPIBaseURL/reset-password'),
        headers: requestHeaders,
        body: jsonEncode({'OTP': otp, 'newPassword': newPassword}));
    dialogsController.hideDialog();

    var data = jsonDecode(response.body);

    if (data['message'] == 'Entered OTP is not valid.') {
      return dialogsController.showErrorDialog('Error',
          'Entered OTP is not valid. Make sure to type OTP carefully.');
    } else if (data['message'] == 'Your password has been updated.') {
      Get.offAllNamed('login');
      Get.snackbar('Password Changed!', 'Your password has been updated.');
    } else {
      dialogsController.showErrorDialog();
    }
  }

  //////////////////////////////////////////////////////////////// Edit Profile

  Future<dynamic> editProfile(String newName, String newCollege) async {
    if (newName.isEmpty || newCollege.isEmpty) {
      return dialogsController.showErrorDialog(
          'Incorrect Data', 'Make sure to enter both name and college.');
    }

    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('authToken');
    final userID = prefs.getString('userID');

    Map<String, String> authorizedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $authToken'
    };

    dialogsController.showLoadingDialog();
    var response = await http.post(Uri.parse('$usersAPIBaseURL/edit-profile'),
        headers: authorizedHeaders,
        body: jsonEncode(
            {'newName': newName, 'newCollege': newCollege, 'userID': userID}));
    dialogsController.hideDialog();

    if (response.statusCode == 200) {
      Restart.restartApp();
    } else {
      return dialogsController.showErrorDialog();
    }
  }

  //////////////////////////////////////////////////////////////// LogOut

  Future<dynamic> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear().then((value) => {Get.offAll(const CreateAccount())});
  }
}
