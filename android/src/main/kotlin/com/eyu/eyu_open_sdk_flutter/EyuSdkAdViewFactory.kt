package com.eyu.eyu_open_sdk_flutter

import FlutterAd
import android.content.Context
import com.eyu.opensdk.ad.base.AdConfigManager
import com.eyu.opensdk.ad.base.model.AdFormat
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class EyuSdkAdViewFactory(createArgsCodec: MessageCodec<Any>?, private var adManager: AdManager) :
    PlatformViewFactory(createArgsCodec) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView? {
        val params = args as Map<*, *>
        val page = params["page"] as String
        val placeId = params["placeId"] as String
        val identifier = params["identifier"] as String? ?: "default"
        val adFormat = AdConfigManager.getInstance().getAdFormat(placeId)
        if (adFormat != null) {
            var platformView =
                adManager.adForPlaceIdAndIdentifier(page, placeId, identifier) as? PlatformView
            if (platformView == null) {
                val ad: FlutterAd? = when (adFormat) {
                    AdFormat.BANNER -> {
                        FlutterBannerAd(context, placeId)
                    }
                    AdFormat.NATIVE -> {
                        FlutterNativeAd(adManager.activity, placeId)
                    }
                    else -> {
                        null
                    }
                }

                if (ad != null) {
                    platformView = adManager.addAd(page, placeId, identifier, ad) as? PlatformView
                }
            }
            return platformView
        }
        throw IllegalArgumentException("placeId not support for BANNER or NATIVE")
    }

}