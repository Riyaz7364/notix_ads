import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notix_ads/notix_ads.dart';
import 'package:notix_ads/notix_ads_platform_interface.dart';
import 'package:notix_ads/notix_ads_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNotixAdsPlatform
    with MockPlatformInterfaceMixin
    implements NotixAdsPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future AppOpen() {
    // TODO: implement AppOpen
    throw UnimplementedError();
  }

  @override
  Future<Widget> loadBanner(int zoneId,
      {BannerAdSize adSize = BannerAdSize.Standard}) {
    // TODO: implement loadBanner
    throw UnimplementedError();
  }
}

void main() {
  final NotixAdsPlatform initialPlatform = NotixAdsPlatform.instance;

  test('$MethodChannelNotixAds is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNotixAds>());
  });

  test('getPlatformVersion', () async {
    NotixAds notixAdsPlugin = NotixAds();
    MockNotixAdsPlatform fakePlatform = MockNotixAdsPlatform();
    NotixAdsPlatform.instance = fakePlatform;

    // expect(await notixAdsPlugin.getPlatformVersion(), '42');
  });
}
