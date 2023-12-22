import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notix_ads/notix_ads_method_channel.dart';

void main() {
  MethodChannelNotixAds platform = MethodChannelNotixAds();
  const MethodChannel channel = MethodChannel('notix_ads');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {});
}
