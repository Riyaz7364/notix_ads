import 'package:flutter/widgets.dart';

import 'notix_ads_platform_interface.dart';

enum BannerAdSize {
  Standard,
  Landscape,
  Rectangle,
}

class NotixAds {
  Future<Widget> loadBanner(int zoneId,
      {BannerAdSize adSize = BannerAdSize.Standard}) {
    return NotixAdsPlatform.instance.loadBanner(zoneId, adSize: adSize);
  }

  Future<dynamic> appOpen(int zoneId) {
    return NotixAdsPlatform.instance.appOpen(zoneId);
  }
}
