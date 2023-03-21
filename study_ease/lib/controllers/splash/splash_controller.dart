import 'dart:async';
import 'package:applovin_max/applovin_max.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_ease/controllers/auth/auth_controller.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:study_ease/controllers/dialogs/dialogs_controller.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class SplashController extends GetxController {
  final authController = Get.put(AuthController());
  final dialogsController = Get.put(DialogsController());

  Future initializePushNotfications() async {
    OneSignal.shared.setAppId('3fa49793-b0e1-4d11-ae9d-70c9114b7927');
    OneSignal.shared.promptUserForPushNotificationPermission();
  }

  Future initializeApplovin() async {
    Map? sdkConfiguration = await AppLovinMAX.initialize(
        'RLPmGmPHHCSOHiIFOWeeTxFCgr8LH5KSN7P62to2fTGakCiGuGeH7ZaKUKwesTOtlg4agPKkDDAzydAyoxbup8');
  }
  Future isLoggedIn() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == false) {
      return dialogsController.showErrorDialog(
          'No Connection', 'Please make sure to connect to internet.');
    }

    initializePushNotfications();

    final prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');

    Timer(
        const Duration(seconds: 2),
        () => {
              if (authToken == null)
                {Get.offAllNamed('/createAccount')}
              else if (authToken.isNotEmpty)
                {
                  initializeApplovin(),
                  print('Initialized AppLovin'),
                  authController.autoLogin(),
                }
            });
  }
}
