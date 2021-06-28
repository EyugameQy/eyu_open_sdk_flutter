package com.eyu.eyu_open_sdk_flutter

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import com.eyu.opensdk.ad.EyuAdManager
import com.eyu.opensdk.ad.base.adapter.BannerAdAdapter
import com.eyu.opensdk.ad.base.adapter.NativeAdAdapter
import io.flutter.plugin.platform.PlatformView

class FlutterNativeAd(ctx: Activity, placeId: String) :PlatformView{
    private var nativeAdAdapter: NativeAdAdapter? = null
    private var context:Activity = ctx

    init {
        nativeAdAdapter = EyuAdManager.getInstance().getNativeAdapter(context,placeId)
    }

    override fun getView(): View {
        return nativeAdAdapter?.targetAdView ?: View(context)
    }

    fun valid():Boolean{
        return nativeAdAdapter?.isAdLoaded ?: false;
    }

    override fun dispose() {
        nativeAdAdapter?.destroy()
    }
}