package com.notix.notix_ads

import android.content.Context
import androidx.annotation.NonNull
import co.notix.appopen.NotixAppOpen
import co.notix.interstitial.NotixInterstitial
import co.notix.push.NotixPush
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** NotixAdsPlugin */
class NotixAdsPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "notix_ads")
        channel.setMethodCallHandler(this)

        context = flutterPluginBinding.applicationContext
        val bannerViewFactory = BannerViewFactory(flutterPluginBinding.binaryMessenger)
        flutterPluginBinding
            .platformViewRegistry
            .registerViewFactory("Notix_banner", bannerViewFactory)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
      when (call.method) {
          "appOpen" -> notixAppOpen(call, result)
          "notixInterstitialLoaderStartLoading" -> notixInterstitialLoaderStartLoading(call, result)
          "notixNotificationInit" -> notixNotificationInit(call, result, context)
        else -> result.notImplemented()
      }
    }
    private fun notixNotificationInit(call: MethodCall, result: Result, context: Context) {
        val notixAppId = call.argument<String>("notixAppId")
            ?: error("notixNotificationInit no notixAppId")
        val notixToken = call.argument<String>("notixToken")
            ?: error("notixNotificationInit no notixToken")

        NotixPush.init(
            context = context,
            notixAppId = notixAppId,
            notixToken = notixToken,
        )
        result.success(null)
    }

private fun notixAppOpen(call: MethodCall, result: Result) {
    val zoneId = call.argument<Number>("zoneId")?.toLong()
    if (zoneId != null) {
      val appOpenLoader = NotixAppOpen.createLoader(zoneId)
      appOpenLoader.startLoading()
      NotixAppOpen.startAutoShow(appOpenLoader)
      result.success("$zoneId ${android.os.Build.VERSION.RELEASE}")
    }
  }
    private fun notixInterstitialLoaderStartLoading(call: MethodCall, result: Result) {
        val zoneId = call.argument<Number>("zoneId")?.toLong()
            ?: error("notixInterstitialCreateLoader no zoneId")
        var interstitialLoader = NotixInterstitial.createLoader(zoneId = zoneId)
        interstitialLoader.startLoading()
        interstitialLoader.doOnNextAvailable { callback ->
            callback?.let { NotixInterstitial.show(it) }
        }
        result.success("Start Loading")
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
