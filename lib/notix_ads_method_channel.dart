import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'notix_ads.dart';
import 'notix_ads_platform_interface.dart';

/// An implementation of [NotixAdsPlatform] that uses method channels.
class MethodChannelNotixAds extends NotixAdsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('notix_ads');

  @override
  Future<dynamic> AppOpen() async {
    final response = await methodChannel.invokeMethod("AppOpen");
    log(response.toString());
  }

  @override
  Future<Widget> loadBanner(int zoneId,
      {BannerAdSize adSize = BannerAdSize.Standard}) async {
    try {
      return AndroidView(
        viewType: "Notix_banner",
        // Pass parameters to the native view
        creationParams: {
          'zoneId': zoneId,
          'adSize': adSize.toString().split('.').last
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    } catch (e) {
      log("Notix Channel Method error = $e");
    }
    return const Center(
      child: Text("Fail to load Ad"),
    );
  }
}
