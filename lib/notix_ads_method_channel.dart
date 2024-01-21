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
  Future<dynamic> appOpen(int zoneId) async {
    final response =
        await methodChannel.invokeMethod("appOpen", {"zoneId": zoneId});
    log(response.toString());
  }

  @override
  Future<dynamic> interstitial(int zoneId) async {
    final response = await methodChannel.invokeMethod(
        "notixInterstitialLoaderStartLoading", {"zoneId": zoneId});
    log(response.toString());
  }

  @override
  Future<dynamic> notificationInit(String notixAppId, String notixToken) async {
    final response = await methodChannel.invokeMethod("notixNotificationInit",
        {"notixAppId": notixAppId, "notixToken": notixToken});
    log(response.toString());
  }

  @override
  Future<Widget> loadBanner(int zoneId,
      {BannerAdSize adSize = BannerAdSize.standard}) async {
    double width = 320, height;
    switch (adSize) {
      case BannerAdSize.standard:
        height = 50;
        break;
      case BannerAdSize.landscape:
        height = 90;
        break;
      case BannerAdSize.rectangle:
        height = 250;
        break;
    }
    try {
      return Center(
        child: SizedBox(
          width: width,
          height: height,
          child: AndroidView(
            viewType: "Notix_banner",
            // Pass parameters to the native view
            creationParams: {
              'zoneId': zoneId,
              'adSize': adSize.toString().split('.').last
            },
            creationParamsCodec: const StandardMessageCodec(),
          ),
        ),
      );
    } catch (e) {
      log("Notix Channel Method error = $e");
    }
    return const Center(
      child: Text("Fail to load Ad"),
    );
  }
}
