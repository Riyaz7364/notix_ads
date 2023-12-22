package com.notix.notix_ads

import android.content.Context
import androidx.annotation.NonNull
import co.notix.appopen.AppOpenLoader
import co.notix.appopen.NotixAppOpen

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** NotixAdsPlugin */
class NotixAdsPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "notix_ads")
    channel.setMethodCallHandler(this)

    context = flutterPluginBinding.applicationContext
    val bannerViewFactory = BannerViewFactory(flutterPluginBinding.binaryMessenger)
    flutterPluginBinding
      .platformViewRegistry
      .registerViewFactory("Notix_banner", bannerViewFactory)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "AppOpen") {
      val appOpenLoader = NotixAppOpen.createLoader(6273334)
      appOpenLoader.startLoading()
      NotixAppOpen.startAutoShow(appOpenLoader)
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
