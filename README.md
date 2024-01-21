# Notix_Ads

This native plugin allows you to display Banner and AppOpen Ads provided by Notix. This is a custom-made script because Notix has not officially released Banner and AppOpen ads for Flutter.

## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  notix_ads: ^x.y.z
```

```dart
import 'package:notix_ads/notix_ads.dart';
```

Replace x.y.z with the latest version of notix_ads from pub.dev.

# Getting Started
## 1. Initialize Banner Ads
First we need to load banner ads before display it.
There are 3 Banner Ads sizes are available for use.

```dart
enum BannerAdSize {
  standard, // 320/50
  landscape, // 320/90
  rectangle, // 320/250
}
```

You can load banner ads by simply call 'NotixAds.loadBanner'

```dart

late Widget banner;
void initState() {
  banner = await NotixAds().loadBanner( /*You Zone ID*/ , BannerAdSize.landscape);
}

// then use `banner` to anywhere in your code to load it.
```

## 2. Show AppOpen Ads
You can use `didChangeAppLifecycleState` to check app satet and call AppOpen Ads

```dart
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      NotixAds().appOpen(/*You Zone ID*/);
    }
  }

```


## 3. Show Notification Ads
Call `NotixAds().NotificationInit` using your notixAppId and notixToken. These credentials can be found on the page of your In-App Android source

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotixAds().NotificationInit(/* notixAppId */, /* notixToken */ );
  runApp(const MyApp());
}

```

## 4. Show Interstitial Ads
You can use `NotixAds().interstitial` to show interstitial. It will load and show Ad in single line

```dart
 NotixAds().interstitial(/*You Zone ID*/);

```
