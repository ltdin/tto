// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/enum.dart';

class AdManager {
  static BannerAd ad;

  static String get banner320x50 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6746226355823304/4193641399';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get midBanner320x250 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6746226355823304/9254396381';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6746226355823304/7202948111';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get mid1Banner320x250 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6746226355823304/8039512901';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6746226355823304/7301146305';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get mid2Banner320x250 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6746226355823304/7407095694';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6746226355823304/7109574611';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get interstitialAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6746226355823304/9330418001';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6746226355823304/8324458095';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static bool get adIsNotExist => (ad == null);

  Future<void> createBannerAd(
    BuildContext context,
    AdmodAdsType adsType,
  ) async {
    printDebug('\n-------------------- Create BannerAd --------------------\n');
    String adUnitId;
    AdSize size;

    // Check and setting adUnitId & size for ads
    if (adsType == AdmodAdsType.BANNER320x50) {
      adUnitId = AdManager.banner320x50;
      size = await AdSize.getAnchoredAdaptiveBannerAdSize(
        Orientation.portrait,
        MediaQuery.of(context).size.width.truncate(),
      );
    } else {
      adUnitId = _getAdUnitId(adsType);
      size = AdSize.mediumRectangle;
    }

    // Create BannerAd for ads
    ad = BannerAd(
      adUnitId: adUnitId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (bannerAd) {
          ad = bannerAd;
        },
        onAdFailedToLoad: (bannerAd, error) {
          printDebug('Ad load failed ');
          bannerAd.dispose();
          ad.dispose();
          ad = null;
        },
        onAdOpened: (Ad ad) => printDebug('Test onAdOpened.'),
        onAdClosed: (Ad ad) => printDebug('Test onAdClosed.'),
      ),
    );

    if (ad != null) {
      await ad.load();
    }
  }

  String _getAdUnitId(AdmodAdsType type) {
    switch (type) {
      case AdmodAdsType.BANNER320x250MID1:
        return mid1Banner320x250;
        break;

      case AdmodAdsType.BANNER320x250MID2:
        return mid2Banner320x250;
        break;

      default:
        return midBanner320x250;
    }
  }
}
