package com.eyu.eyu_open_sdk_flutter

import FlutterAd
import android.app.Activity
import android.util.Log
import android.view.View
import com.eyu.opensdk.ad.EyuAdManager
import com.eyu.opensdk.ad.base.adapter.NativeAdAdapter
import io.flutter.plugin.platform.PlatformView

class FlutterNativeAd(ctx: Activity, var placeId: String) : FlutterAd(),PlatformView,FlutterDestroyableAd {
    private var nativeAdAdapter: NativeAdAdapter? = null
    private var context: Activity = ctx

    override fun getView(): View {
        if(nativeAdAdapter == null){
            nativeAdAdapter = EyuAdManager.getInstance().getNativeAdapter(context, placeId)
        }
        return nativeAdAdapter?.targetAdView ?: View(context)
    }

    fun valid(): Boolean {
        return nativeAdAdapter?.isAdLoaded ?: false;
    }

    override fun dispose() {
    }

    override fun destroy() {
        nativeAdAdapter?.destroy()
    }
}