import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/widgets/advertising/ad_helper.dart';

class AdmodInterstitial {
  Future<void> openInterstitialAd({
    BuildContext context,
    VoidCallback onAdShowed,
    VoidCallback onAdDismissed,
    VoidCallback onAdFailedToShow,
  }) async {
    // Show loading
    AppHelpers.showProcessDialog(context);

    // Load InterstitialAd
    InterstitialAd.load(
      adUnitId: AdManager.interstitialAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Setting before show
          Navigator.pop(context);
          ad.setImmersiveMode(true);

          // Show ads
          showInterstitialAd(
            interstitialAd: ad,
            onAdShowed: onAdShowed,
            onAdDismissed: onAdDismissed,
            onAdFailedToShow: onAdFailedToShow,
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          printDebug('InterstitialAd faileddddddddddddddddd');
          openInterstitialAd();
        },
      ),
    );
  }

  void showInterstitialAd({
    InterstitialAd interstitialAd,
    VoidCallback onAdShowed,
    VoidCallback onAdDismissed,
    VoidCallback onAdFailedToShow,
  }) {
    if (interstitialAd == null) {
      printDebug('Warning: attempt to show interstitial before loaded.');
      return;
    }

    interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        if (onAdShowed != null) {
          onAdShowed.call();
        }
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        if (onAdDismissed != null) {
          onAdDismissed.call();
        }

        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        if (onAdFailedToShow != null) {
          onAdFailedToShow.call();
        }

        ad.dispose();
      },
    );
    interstitialAd.show();
    interstitialAd = null;
  }
}
