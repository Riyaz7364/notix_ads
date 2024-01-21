import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notix_ads/notix_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotixAds().notificationInit('p6xxxx', 'cxxxc7744fa847f4a59f7beac9fxxxx');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? _banner;
  final _notixAdsPlugin = NotixAds();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      _banner =
          await _notixAdsPlugin.loadBanner(0000) ?? Text("Fail to load banner");
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: _banner,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // _notixAdsPlugin.appOpen(xxxx);
            _notixAdsPlugin.interstitial(0000);
          },
        ),
      ),
    );
  }
}
