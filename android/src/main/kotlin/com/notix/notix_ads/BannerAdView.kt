package com.notix.notix_ads

import android.content.Context
import android.view.View
import co.notix.banner.BannerRequest
import co.notix.banner.BannerSize
import co.notix.banner.NotixBannerView
import co.notix.utils.ExperimentalNotixApi
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import java.util.*

@OptIn(ExperimentalNotixApi::class)
class BannerAdView(
    context: Context,
    messenger: BinaryMessenger,
    viewId: Int,
    creationParams: Map<*, *>?
) : PlatformView {
    private val channel = MethodChannel(messenger, "miner_$viewId")

    @OptIn(ExperimentalNotixApi::class)
    private var banner = NotixBannerView(context)

    init {
        print(creationParams)
        val adSizeName = creationParams?.get("adSize") as? String
        val zoneId = creationParams?.get("zoneId") as Int
        val size = when (adSizeName) {
            "Standard" -> BannerSize.Inline(width = 320, maxHeight = 50)
            "Landscape" -> BannerSize.Inline(width = 320, maxHeight = 90)
            "Rectangle" -> BannerSize.Inline(width = 320, maxHeight = 250)
            else -> throw IllegalArgumentException("Invalid ad size: $adSizeName")
        }
        val bannerRequest = BannerRequest(zoneId = zoneId.toLong(), size = size)
        banner.load(bannerRequest)

    }

    override fun getView(): View {
        return banner
    }

    override fun dispose() {
        // Implement dispose logic if needed
    }
}