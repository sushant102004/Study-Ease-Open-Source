import 'dart:io';
import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:get/get.dart';

class ApplovinController extends GetxController {
  final String _interstitial_ad_unit_id = '	e53e703af176aa29';

  var _interstitialRetryAttempt = 0;

  void initializeInterstitialAds() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
        print('Interstitial ad loaded from ' + ad.networkName);

        // Reset retry attempt
        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();

        print('Interstitial ad failed to load with code ' +
            error.code.toString() +
            ' - retrying in ' +
            retryDelay.toString() +
            's');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(_interstitial_ad_unit_id);
        });
      },
      onAdDisplayedCallback: (ad) {},
      onAdDisplayFailedCallback: (ad, error) {},
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {},
    ));

    AppLovinMAX.loadInterstitial(_interstitial_ad_unit_id);
  }

  showIntersitialAd() async {
    print('Inside Show Ad');
    bool isReady =
        (await AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id))!;
    if (isReady) {
      AppLovinMAX.showInterstitial(_interstitial_ad_unit_id);
    } else {
      print('Ad not ready yet');
    }
  }
}
