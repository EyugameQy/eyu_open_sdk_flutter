package com.eyu.eyu_open_sdk_flutter

import android.content.Context
import android.util.Log
import android.view.View
import com.eyu.opensdk.ad.EyuAdManager
import com.eyu.opensdk.ad.base.adapter.BannerAdAdapter
import io.flutter.plugin.platform.PlatformView

class FlutterBannerAd(ctx: Context, placeId: String) :PlatformView{
    private var bannerAdAdapter:BannerAdAdapter? = null
    private var context:Context = ctx

    init {
        bannerAdAdapter = EyuAdManager.getInstance().getBannerAdapter(placeId)
    }

    override fun getView(): View {
        return bannerAdAdapter?.adView ?: View(context)
    }

    fun valid():Boolean{
        return bannerAdAdapter?.isAdLoaded ?: false;
    }

    override fun dispose() {
        bannerAdAdapter?.destroy()
    }
}