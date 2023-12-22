import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'notix_ads.dart';
import 'notix_ads_method_channel.dart';

abstract class NotixAdsPlatform extends PlatformInterface {
  /// Constructs a NotixAdsPlatform.
  NotixAdsPlatform() : super(token: _token);

  static final Object _token = Object();

  static NotixAdsPlatform _instance = MethodChannelNotixAds();

  /// The default instance of [NotixAdsPlatform] to use.
  ///
  /// Defaults to [MethodChannelNotixAds].
  static NotixAdsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NotixAdsPlatform] when
  /// they register themselves.
  static set instance(NotixAdsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Widget> loadBanner(int zoneId,
      {BannerAdSize adSize = BannerAdSize.Standard}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<dynamic> AppOpen(int zoneId) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
