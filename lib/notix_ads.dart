import 'package:flutter/widgets.dart';

import 'notix_ads_platform_interface.dart';

enum BannerAdSize {
  standard,
  landscape,
  rectangle,
}

class NotixAds {
  Future<Widget> loadBanner(int zoneId,
      {BannerAdSize adSize = BannerAdSize.standard}) {
    return NotixAdsPlatform.instance.loadBanner(zoneId, adSize: adSize);
  }

  Future<dynamic> appOpen(int zoneId) {
    return NotixAdsPlatform.instance.appOpen(zoneId);
  }

  Future<dynamic> interstitial(int zoneId) {
    return NotixAdsPlatform.instance.interstitial(zoneId);
  }

  Future<dynamic> notificationInit(String notixAppId, String notixToken) {
    return NotixAdsPlatform.instance.notificationInit(notixAppId, notixToken);
  }
}
