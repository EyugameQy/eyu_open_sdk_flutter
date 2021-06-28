package com.eyu.eyu_open_sdk_flutter

import android.content.Context
import com.eyu.opensdk.ad.base.AdConfigManager
import com.eyu.opensdk.ad.base.model.AdFormat
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class EyuSdkAdViewFactory(createArgsCodec: MessageCodec<Any>?, private var adManager: AdManager) : PlatformViewFactory(createArgsCodec) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val placeId = args as String
        val adFormat = AdConfigManager.getInstance().getAdFormat(placeId)
        if (adFormat != null) {
            if (adFormat == AdFormat.BANNER) {
                return FlutterBannerAd(context, placeId)
            } else if (adFormat == AdFormat.NATIVE) {
                return FlutterNativeAd(adManager.activity, placeId)
            }
        }
        throw IllegalArgumentException("placeId not support for BANNER or NATIVE")
    }
}